// アプリケーションのルーティング設定（go_router）
// Riverpod ProviderでrouterConfigを公開

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' show Ref; // Refを明示的にインポート

import '../../features/user/pomodoro_timer/4_presentation/2_pages/pomodoro_page.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {
  // ルート定義
  final routes = <RouteBase>[
    GoRoute(
      path: '/',
      name: 'home',
      pageBuilder: (context, state) => const MaterialPage(
        key: ValueKey('home'),
        child: PomodoroPage(),
      ),
    ),
  ];

  return GoRouter(
    routes: routes,
    initialLocation: '/',
  );
}