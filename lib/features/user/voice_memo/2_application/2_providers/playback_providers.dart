// Application層: 再生関連のProvider定義
// 役割: NotifierやDataSourceのDIエントリポイント（ロジックは持たない）

import 'package:riverpod/riverpod.dart';

import '../../3_infrastructure/1_data_sources/1_local/android_media_controls_channel.dart';

// Androidメディアコントロール連携（MethodChannelブリッジ）のProvider
final androidMediaControlsChannelProvider = Provider<AndroidMediaControlsChannel>((ref) {
  return AndroidMediaControlsChannel();
});