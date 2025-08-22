// Presentation層: ボイスメモ詳細ページ
// 役割: 指定IDの VoiceMemo を取得して表示します。Riverpod Notifier を購読し、初回マウント時に fetch を実行します。

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
 // 追加: 音声再生

import '../../2_application/1_states/voice_memo_detail_state.dart';
import '../../2_application/3_notifiers/voice_memo_detail_notifier.dart';
import '../../2_application/3_notifiers/playback_notifier.dart'; // 追加: 再生制御をNotifier経由に変更
import '../../2_application/1_states/playback_state.dart'; // 追加: PlaybackStatus参照用

class VoiceMemoDetailPage extends HookConsumerWidget {
  final String id;
  const VoiceMemoDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 詳細状態を購読
    final AsyncValue<VoiceMemoDetailState> asyncState = ref.watch(voiceMemoDetailNotifierProvider);

    // マウント時に対象IDのメモを取得（id が変わった場合も再取得）
    useEffect(() {
      Future.microtask(() => ref.read(voiceMemoDetailNotifierProvider.notifier).fetch(id));
      return null; // クリーンアップ不要
    }, [id]);

    // 再生用: mm:ss 表記を作るヘルパー
    String formatTime(Duration d) {
      final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
      final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
      return '$m:$s';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('メモ詳細'),
      ),
      body: asyncState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => _ErrorView(
          message: err.toString(),
          onRetry: () => ref.read(voiceMemoDetailNotifierProvider.notifier).fetch(id),
        ),
        data: (state) {
          final item = state.item;
          if (item == null) {
            return _EmptyView(
              onReload: () => ref.read(voiceMemoDetailNotifierProvider.notifier).fetch(id),
            );
          }

          final tagsLabel = item.tags.map((t) => t.name).join(', ');
          final durationSec = (item.durationMs / 1000).round();

          // 再生状態（PlaybackNotifier）を購読
          final playback = ref.watch(playbackNotifierProvider);
          final playbackCtl = ref.read(playbackNotifierProvider.notifier);

          // 音声ソースのセット（item.audioPathが変わるたびに更新）
          useEffect(() {
            Future.microtask(() => playbackCtl.load(item.audioPath));
            return null; // クリーンアップはNotifier側で実施
          }, [item.audioPath]);

          // 再生/一時停止のトグル
          Future<void> togglePlay() async {
            try {
              if (playback.status == PlaybackStatus.playing) {
                await playbackCtl.pause();
              } else {
                await playbackCtl.play();
              }
            } catch (e) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('再生に失敗しました: $e')),
                );
              }
            }
          }

          // 相対シーク（ミリ秒）。0〜totalの範囲にクランプ
          Future<void> seekRelativeMs(int deltaMs, Duration total) async {
            await playbackCtl.seekRelative(deltaMs);
          }

          final total = playback.duration.inMilliseconds == 0
              ? Duration(milliseconds: item.durationMs)
              : playback.duration;
          final current = playback.position > total ? total : playback.position;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // タイトル
              Text(
                item.title.isEmpty ? '(無題)' : item.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 12),

              // メタ情報（タグ/長さ/状態）
              Wrap(
                spacing: 8,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  if (tagsLabel.isNotEmpty)
                    Row(mainAxisSize: MainAxisSize.min, children: [
                      const Icon(Icons.tag, size: 16),
                      const SizedBox(width: 4),
                      Text('#$tagsLabel'),
                    ]),
                  Row(mainAxisSize: MainAxisSize.min, children: [
                    const Icon(Icons.timer, size: 16),
                    const SizedBox(width: 4),
                    Text('${durationSec}s'),
                  ]),
                  if (item.isStarred)
                    const Chip(
                      avatar: Icon(Icons.star, color: Colors.amber, size: 16),
                      label: Text('スター'),
                    ),
                  if (item.isTrashed)
                    const Chip(
                      avatar: Icon(Icons.delete, color: Colors.redAccent, size: 16),
                      label: Text('ゴミ箱'),
                    ),
                ],
              ),

              const SizedBox(height: 24),

              // ===== 再生コントロール =====
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          // 10秒戻る
                          IconButton(
                            onPressed: () => seekRelativeMs(-10000, total),
                            icon: const Icon(Icons.replay_10),
                            tooltip: '10秒戻る',
                          ),
                          const SizedBox(width: 4),
                          // 再生/一時停止ボタン
                          IconButton(
                            onPressed: togglePlay,
                            iconSize: 40,
                            icon: Icon(
                              playback.status == PlaybackStatus.playing
                                  ? Icons.pause_circle_filled
                                  : Icons.play_circle_fill,
                            ),
                          ),
                          const SizedBox(width: 4),
                          // 10秒進む
                          IconButton(
                            onPressed: () => seekRelativeMs(10000, total),
                            icon: const Icon(Icons.forward_10),
                            tooltip: '10秒進む',
                          ),
                          const SizedBox(width: 8),
                          // 進捗スライダー
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Slider(
                                  value: current.inMilliseconds.toDouble(),
                                  min: 0,
                                  max: total.inMilliseconds.toDouble().clamp(1.0, double.infinity),
                                  onChanged: (v) async {
                                    final d = Duration(milliseconds: v.round());
                                    await playbackCtl.seek(d);
                                  },
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(formatTime(current)),
                                    Text(formatTime(total)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          // 再生速度切り替え（ポップアップメニュー）
                          PopupMenuButton<double>(
                            tooltip: '再生速度',
                            initialValue: playback.speed,
                            onSelected: (v) => playbackCtl.setSpeed(v),
                            itemBuilder: (context) => const [
                              PopupMenuItem(value: 0.5, child: Text('0.5x')),
                              PopupMenuItem(value: 1.0, child: Text('1.0x')),
                              PopupMenuItem(value: 1.5, child: Text('1.5x')),
                              PopupMenuItem(value: 2.0, child: Text('2.0x')),
                            ],
                            child: Chip(
                              label: Text('${playback.speed.toStringAsFixed(1)}x'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),
              // 文字起こしなど詳細本文は将来拡張
              const Text('詳細本文（文字起こしなど）は後続ステップで実装します。'),
            ],
          );
        },
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: Colors.redAccent, size: 36),
            const SizedBox(height: 8),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('再試行'),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  final VoidCallback onReload;
  const _EmptyView({required this.onReload});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.info_outline, size: 36),
            const SizedBox(height: 8),
            const Text('対象のメモが見つかりませんでした。'),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: onReload,
              icon: const Icon(Icons.refresh),
              label: const Text('再読み込み'),
            ),
          ],
        ),
      ),
    );
  }
}