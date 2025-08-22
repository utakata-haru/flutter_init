// Application層: Repository のプロバイダ定義
// 役割: インフラ層で実装される VoiceMemoRepository を DI で差し替えるエントリポイント

import 'package:riverpod/riverpod.dart';

import '../../1_domain/2_repositories/voice_memo_repository.dart';

// インフラ層で ProviderScope(overrides: [...]) にて上書きしてください。
final voiceMemoRepositoryProvider = Provider<VoiceMemoRepository>((ref) {
  throw UnimplementedError(
    'voiceMemoRepositoryProvider はインフラ層で上書き提供してください。',
  );
});