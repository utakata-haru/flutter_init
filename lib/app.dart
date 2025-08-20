// アプリケーションのルート設定とテーマ適用
// MaterialApp.router + go_router を用いたルーティング設定

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/shared/design_system/2_application/3_notifiers/theme_notifier.dart';
import 'core/routing/app_router.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeNotifierProvider);
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Pomodoro Timer',
      debugShowCheckedModeBanner: false,
      theme: themeState.themeData,
      routerConfig: router,
    );
  }
}