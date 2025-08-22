import 'package:flutter/material.dart';
// Riverpod/DI 用のインポート
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/routing/app_router.dart';
import 'features/user/voice_memo/2_application/2_providers/voice_memo_repository_provider.dart';
import 'features/user/voice_memo/3_infrastructure/3_repositories/voice_memo_repository_impl.dart';

void main() {
  // ProviderScope でアプリ全体をラップし、DIのエントリポイントを提供
  runApp(
    ProviderScope(
      overrides: [
        // リポジトリをローカルDB実装で提供
        voiceMemoRepositoryProvider.overrideWith(
          (ref) => VoiceMemoRepositoryImpl(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // アプリのルートは go_router を用いた MaterialApp.router を採用します。
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Voice Memo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: appRouter,
    );
  }
}
