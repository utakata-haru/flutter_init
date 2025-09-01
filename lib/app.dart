import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'features/user/note_management/4_presentation/2_pages/note_list_page.dart';
import 'features/user/note_management/4_presentation/2_pages/note_detail_page.dart';

/// ルーター設定
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      // ルート（メモ一覧画面）
      GoRoute(
        path: '/',
        builder: (context, state) => const NoteListPage(),
      ),
      
      // 新規メモ作成画面
      GoRoute(
        path: '/note/create',
        builder: (context, state) => const NoteDetailPage(
          isEditing: false,
        ),
      ),
      
      // メモ詳細画面
      GoRoute(
        path: '/note/:id',
        builder: (context, state) {
          final noteId = state.pathParameters['id']!;
          return NoteDetailPage(
            noteId: noteId,
            isEditing: false,
          );
        },
      ),
      
      // メモ編集画面
      GoRoute(
        path: '/note/:id/edit',
        builder: (context, state) {
          final noteId = state.pathParameters['id']!;
          return NoteDetailPage(
            noteId: noteId,
            isEditing: true,
          );
        },
      ),
    ],
  );
});

/// メインアプリケーション
class NoteApp extends ConsumerWidget {
  const NoteApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    
    return MaterialApp.router(
      title: 'シンプルメモアプリ',
      debugShowCheckedModeBanner: false,
      
      // Material Design 3テーマ
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        typography: Typography.material2021(),
        // カードのデフォルト設定
        cardTheme: const CardThemeData(
          elevation: 2,
          margin: EdgeInsets.zero,
        ),
        // アプリバーのデフォルト設定
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 0,
          scrolledUnderElevation: 1,
        ),
        // フローティングアクションボタンのデフォルト設定
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          elevation: 3,
          highlightElevation: 6,
        ),
      ),
      
      // ダークテーマ
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        typography: Typography.material2021(),
        cardTheme: const CardThemeData(
          elevation: 2,
          margin: EdgeInsets.zero,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 0,
          scrolledUnderElevation: 1,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          elevation: 3,
          highlightElevation: 6,
        ),
      ),
      
      // システムの設定に従ってテーマを自動切り替え
      themeMode: ThemeMode.system,
      
      // Go Router設定
      routerConfig: router,
    );
  }
}
