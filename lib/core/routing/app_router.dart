// ルーティング設定: go_router によるアプリ全体のルート定義
// 初期画面をボイスメモ一覧に設定します。

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../features/user/voice_memo/4_presentation/2_pages/voice_memo_list_page.dart';
import '../../../features/user/voice_memo/4_presentation/2_pages/voice_memo_detail_page.dart';
import '../../../features/user/voice_memo/4_presentation/2_pages/voice_memo_edit_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/memos',
  routes: <RouteBase>[
    GoRoute(
      path: '/memos',
      name: 'voiceMemoList',
      pageBuilder: (context, state) => const MaterialPage(
        child: VoiceMemoListPage(),
      ),
      routes: [
        // 詳細: /memos/:id
        GoRoute(
          path: ':id',
          name: 'voiceMemoDetail',
          pageBuilder: (context, state) {
            final id = state.pathParameters['id']!;
            return MaterialPage(
              child: VoiceMemoDetailPage(id: id),
            );
          },
        ),
        GoRoute(
          path: 'new',
          name: 'voiceMemoCreate',
          pageBuilder: (context, state) => const MaterialPage(
            child: VoiceMemoEditPage(),
          ),
        ),
      ],
    ),
  ],
);