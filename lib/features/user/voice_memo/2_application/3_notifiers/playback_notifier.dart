// Application層: 再生制御 Notifier（Riverpodコード生成）
// 役割: AudioPlayer を用いた再生の一元管理と状態更新、（将来）Android通知連携

import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../1_states/playback_state.dart';
import '../2_providers/playback_providers.dart';

part 'playback_notifier.g.dart';

@riverpod
class PlaybackNotifier extends _$PlaybackNotifier {
  late final AudioPlayer _player;
  StreamSubscription<PlayerState>? _subState;
  StreamSubscription<Duration>? _subPos;
  StreamSubscription<Duration>? _subDur;
  StreamSubscription<void>? _subComplete;

  @override
  PlaybackState build() {
    // 初期状態
    final initial = PlaybackState.initial();

    // AudioPlayer 初期化
    _player = AudioPlayer();

    // ストリーム購読して状態を反映
    _subState = _player.onPlayerStateChanged.listen((s) {
      final mapped = _mapPlayerState(s);
      state = state.copyWith(status: mapped);
      // 通知側へ状態反映（段階1はNO-OP）
      _notifyNative();
    });
    _subPos = _player.onPositionChanged.listen((p) {
      state = state.copyWith(position: p);
      _notifyNative();
    });
    _subDur = _player.onDurationChanged.listen((d) {
      state = state.copyWith(duration: d);
      _notifyNative();
    });
    _subComplete = _player.onPlayerComplete.listen((_) async {
      try {
        await _player.stop();
        await _player.seek(Duration.zero);
      } catch (_) {}
      state = state.copyWith(
        status: PlaybackStatus.stopped,
        position: Duration.zero,
      );
      _notifyNative();
    });

    // 破棄時に購読解除＆プレイヤー破棄
    ref.onDispose(() async {
      await _subState?.cancel();
      await _subPos?.cancel();
      await _subDur?.cancel();
      await _subComplete?.cancel();
      try {
        await _player.stop();
      } catch (_) {}
      await _player.dispose();
    });

    // Android側のコールバック登録（段階1はNO-OP）
    ref.read(androidMediaControlsChannelProvider).registerCallbacks();

    return initial;
  }

  // 音声ファイルをロード（自動再生しない）
  Future<void> load(String filePath) async {
    state = state.copyWith(status: PlaybackStatus.loading, errorMessage: null);
    try {
      // Android向け: オーディオフォーカス/セッション設定（duck優先）
      try {
        await _player.setAudioContext(AudioContext(
          android: AudioContextAndroid(
            contentType: AndroidContentType.music,
            usageType: AndroidUsageType.media,
            audioFocus: AndroidAudioFocus.gainTransientMayDuck,
          ),
        ));
      } catch (_) {
        // Web/非対応プラットフォームでは無視
      }

      await _player.stop();
      await _player.setSource(DeviceFileSource(filePath));

      // 再生位置/長さを初期化
      state = state.copyWith(
        status: PlaybackStatus.stopped,
        position: Duration.zero,
        // duration は onDurationChanged で更新される
        currentFilePath: filePath,
      );
      _notifyNative();
    } catch (e) {
      state = state.copyWith(status: PlaybackStatus.error, errorMessage: e.toString());
    }
  }

  Future<void> play() async {
    try {
      await _player.resume();
      // onPlayerStateChanged でstatus反映される
    } catch (e) {
      state = state.copyWith(status: PlaybackStatus.error, errorMessage: e.toString());
    }
  }

  Future<void> pause() async {
    try {
      await _player.pause();
    } catch (e) {
      state = state.copyWith(status: PlaybackStatus.error, errorMessage: e.toString());
    }
  }

  Future<void> seek(Duration d) async {
    try {
      await _player.seek(d);
      // positionはonPositionChangedで反映
    } catch (e) {
      state = state.copyWith(status: PlaybackStatus.error, errorMessage: e.toString());
    }
  }

  Future<void> seekRelative(int deltaMs) async {
    final totalMs = (state.duration.inMilliseconds == 0 ? 0 : state.duration.inMilliseconds);
    final currentMs = state.position.inMilliseconds;
    final target = (currentMs + deltaMs).clamp(0, totalMs > 0 ? totalMs : 1);
    await seek(Duration(milliseconds: target));
  }

  Future<void> setSpeed(double rate) async {
    try {
      await _player.setPlaybackRate(rate);
      state = state.copyWith(speed: rate);
      _notifyNative();
    } catch (e) {
      state = state.copyWith(status: PlaybackStatus.error, errorMessage: e.toString());
    }
  }

  PlaybackStatus _mapPlayerState(PlayerState s) {
    switch (s) {
      case PlayerState.playing:
        return PlaybackStatus.playing;
      case PlayerState.paused:
        return PlaybackStatus.paused;
      case PlayerState.stopped:
        return PlaybackStatus.stopped;
      case PlayerState.completed:
        // completed は onPlayerComplete で停止に戻す
        return PlaybackStatus.stopped;
      case PlayerState.disposed:
        // disposed時はstoppedとして扱う
        return PlaybackStatus.stopped;
    }
  }

  Future<void> _notifyNative() async {
    final file = state.currentFilePath ?? '';
    final title = file.isEmpty ? 'Voice Memo' : file.split('/').last;
    await ref.read(androidMediaControlsChannelProvider).showOrUpdateNotification(
      title: title,
      isPlaying: state.status == PlaybackStatus.playing,
      position: state.position,
      duration: state.duration,
    );
  }
}