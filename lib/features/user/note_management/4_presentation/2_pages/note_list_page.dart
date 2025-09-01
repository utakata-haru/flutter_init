import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../3_application/3_notifiers/note_list_notifier.dart';
import '../../3_application/3_notifiers/note_form_notifier.dart';
import '../1_widgets/3_organisms/note_list_view.dart';

/// メモ一覧画面
/// 
/// 保存されたメモの一覧表示、検索、フィルタリング機能を提供
/// 新規メモ作成への遷移も担当
class NoteListPage extends HookConsumerWidget {
  const NoteListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    // Notifierの購読
    final noteState = ref.watch(noteListNotifierProvider);
    final noteNotifier = ref.read(noteListNotifierProvider.notifier);
    
    // ローカル状態
    final searchQuery = useState('');
    final viewMode = useState(NoteViewMode.card);
    final sortOption = useState(NoteSortOption.updatedAtDesc);
    
    // 初期化処理
    useEffect(() {
      Future.microtask(() => noteNotifier.loadNotes());
      return null;
    }, []);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('メモ'),
        backgroundColor: colorScheme.surface,
        surfaceTintColor: colorScheme.surfaceTint,
        actions: [
          // 検索ボタン
          IconButton(
            onPressed: () {
              // 検索モードの切り替え
            },
            icon: const Icon(Icons.search),
            tooltip: '検索',
          ),
          
          // メニューボタン
          PopupMenuButton<String>(
            onSelected: (value) async {
              switch (value) {
                case 'refresh':
                  await noteNotifier.loadNotes();
                  break;
                case 'settings':
                  // 設定画面への遷移
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'refresh',
                child: ListTile(
                  leading: Icon(Icons.refresh),
                  title: Text('更新'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const PopupMenuItem(
                value: 'settings',
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('設定'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ],
      ),
      
      body: noteState.when(
        initial: () => const Center(
          child: CircularProgressIndicator(),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        loaded: (notes) => NoteListView(
          notes: notes,
          searchQuery: searchQuery.value,
          viewMode: viewMode.value,
          sortOption: sortOption.value,
          onNoteTap: (note) {
            // メモ詳細画面への遷移
            context.push('/note/${note.id}');
          },
          onNoteEdit: (note) {
            // メモ編集画面への遷移
            context.push('/note/${note.id}/edit');
          },
          onNoteDelete: (note) async {
            // 削除確認ダイアログ
            final confirmed = await _showDeleteConfirmDialog(context, note.title);
            if (confirmed) {
              // FormNotifierを使って削除
              final formNotifier = ref.read(noteFormNotifierProvider.notifier);
              await formNotifier.deleteNote(note.id);
              // 削除後にリストを更新
              await noteNotifier.loadNotes(isRefresh: true);
            }
          },
          onSearch: (query) {
            searchQuery.value = query;
            // TODO: 検索機能の実装
          },
          onRefresh: () {
            noteNotifier.loadNotes();
          },
          onViewModeChanged: (mode) {
            viewMode.value = mode;
          },
          onSortChanged: (option) {
            sortOption.value = option;
            // TODO: ソート機能の実装
          },
        ),
        error: (error) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                'エラーが発生しました',
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                error,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => noteNotifier.loadNotes(),
                child: const Text('再試行'),
              ),
            ],
          ),
        ),
      ),
      
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // 新規メモ作成画面への遷移
          context.push('/note/create');
        },
        icon: const Icon(Icons.add),
        label: const Text('新規メモ'),
        tooltip: '新しいメモを作成',
      ),
      
      // 統計情報やフィルタ情報の表示
      bottomNavigationBar: noteState.when(
        initial: () => null,
        loading: () => null,
        loaded: (notes) => _buildBottomInfo(context, notes.length),
        error: (_) => null,
      ),
    );
  }
  
  /// 削除確認ダイアログ
  Future<bool> _showDeleteConfirmDialog(BuildContext context, String noteTitle) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('メモを削除'),
        content: Text('「$noteTitle」を削除しますか？\nこの操作は元に戻せません。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('キャンセル'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
            child: const Text('削除'),
          ),
        ],
      ),
    );
    
    return result ?? false;
  }
  
  /// 底部情報バー
  Widget? _buildBottomInfo(BuildContext context, int noteCount) {
    if (noteCount == 0) return null;
    
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        border: Border(
          top: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.note,
            size: 16,
            color: colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 8),
          Text(
            '$noteCount件のメモ',
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const Spacer(),
          Text(
            '最終更新: 今日',
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
