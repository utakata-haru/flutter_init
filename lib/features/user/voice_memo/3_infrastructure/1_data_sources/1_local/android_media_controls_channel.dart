// Infrastructure層: Androidメディアコントロール連携（MethodChannelブリッジ）
// 役割: 通知・ロック画面のメディアコントロールとやりとりするためのDart側窓口
// 注意: 段階1ではスタブ実装（NO-OP）とし、ネイティブ実装後に接続します。

import 'dart:async';

class AndroidMediaControlsChannel {
  // 将来的にMethodChannelをここで初期化します
  // static const _channel = MethodChannel('com.example.flutter_init/media_controls');

  // 通知の表示または更新（タイトル/再生状態など）
  Future<void> showOrUpdateNotification({
    required String title,
    required bool isPlaying,
    Duration? position,
    Duration? duration,
  }) async {
    // 段階1: NO-OP（Androidネイティブ実装で置き換え）
    return;
  }

  // 通知の非表示
  Future<void> hideNotification() async {
    // 段階1: NO-OP
    return;
  }

  // メディアボタンなどのコールバック登録
  Future<void> registerCallbacks() async {
    // 段階1: NO-OP
    return;
  }
}