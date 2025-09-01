import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../3_application/3_notifiers/note_form_notifier.dart';
import '../../3_application/3_notifiers/note_list_notifier.dart';
import '../../1_domain/1_entities/note_entity.dart';
import '../1_widgets/3_organisms/note_editor_section.dart';

/// メモ詳細・編集画面
/// 
/// メモの詳細表示、編集、削除機能を提供
/// 新規作成時と編集時の両方に対応
class NoteDetailPage extends HookConsumerWidget {
  const NoteDetailPage({
    super.key,
    this.noteId,
    this.isEditing = false,
  });

  /// メモID（新規作成時はnull）
  final String? noteId;
  
  /// 編集モードかどうか
  final bool isEditing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    // Notifierの購読
    final formState = ref.watch(noteFormNotifierProvider);
    final formNotifier = ref.read(noteFormNotifierProvider.notifier);
    final listNotifier = ref.read(noteListNotifierProvider.notifier);
    
    // ローカル状態
    final showPreview = useState(false);
    final isNewNote = noteId == null;
    
    // 現在のメモを取得
    final currentNote = useState<NoteEntity?>(null);
    
    // 初期化処理
    useEffect(() {
      Future.microtask(() async {
        if (isNewNote) {
          // 新規作成モード
          formNotifier.startEditing();
        } else {
          // 編集モード - メモを読み込み
          await formNotifier.loadNoteForEditing(noteId!);
        }
      });
      return null;
    }, [noteId]);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(isNewNote ? '新規メモ' : 'メモ編集'),
        backgroundColor: colorScheme.surface,
        surfaceTintColor: colorScheme.surfaceTint,
        leading: IconButton(
          onPressed: () {
            // 変更チェックと確認（簡易版）
            _handleBackNavigation(context, false); // TODO: 変更チェック実装
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          // プレビュー切り替えボタン
          if (!isNewNote)
            IconButton(
              onPressed: () {
                showPreview.value = !showPreview.value;
              },
              icon: Icon(showPreview.value ? Icons.edit : Icons.preview),
              tooltip: showPreview.value ? '編集モード' : 'プレビューモード',
            ),
          
          // その他メニュー
          PopupMenuButton<String>(
            onSelected: (value) async {
              switch (value) {
                case 'share':
                  // 共有機能
                  await _shareNote(context, currentNote.value);
                  break;
                case 'copy':
                  // コピー機能
                  await _copyNote(context, currentNote.value);
                  break;
                case 'delete':
                  // 削除機能
                  if (currentNote.value != null) {
                    await _deleteNote(context, ref, currentNote.value!);
                  }
                  break;
              }
            },
            itemBuilder: (context) => [
              if (!isNewNote) ...[
                const PopupMenuItem(
                  value: 'share',
                  child: ListTile(
                    leading: Icon(Icons.share),
                    title: Text('共有'),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                const PopupMenuItem(
                  value: 'copy',
                  child: ListTile(
                    leading: Icon(Icons.content_copy),
                    title: Text('コピー'),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('削除'),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
      
      body: formState.when(
        initial: () => const Center(
          child: CircularProgressIndicator(),
        ),
        editing: (title, content, isValid, validationErrors, originalNote) => NoteEditorSection(
          note: originalNote,
          initialTitle: title,
          initialContent: content,
          onSave: (title, content) async {
            // フォームを更新してから保存
            formNotifier.updateForm(title: title, content: content);
            await formNotifier.saveNote();
            
            // リストを更新
            listNotifier.loadNotes(isRefresh: true);
          },
          onCancel: () {
            // 変更チェックと確認
            _handleBackNavigation(context, title.isNotEmpty || content.isNotEmpty);
          },
          onDelete: isNewNote ? null : () async {
            if (originalNote != null) {
              await _deleteNote(context, ref, originalNote);
            }
          },
          onPreviewToggle: (preview) {
            showPreview.value = preview;
          },
          isLoading: false,
          showPreview: showPreview.value,
          validationErrors: validationErrors ?? [],
        ),
        saving: () => const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('保存中...'),
            ],
          ),
        ),
        saved: (note) {
          // 保存完了時の処理
          Future.microtask(() {
            if (context.mounted) {
              context.pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('メモを保存しました')),
              );
            }
          });
          return const Center(child: CircularProgressIndicator());
        },
        deleting: () => const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('削除中...'),
            ],
          ),
        ),
        deleted: () {
          // 削除完了時の処理
          Future.microtask(() {
            if (context.mounted) {
              context.pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('メモを削除しました')),
              );
            }
          });
          return const Center(child: CircularProgressIndicator());
        },
        error: (message) => Center(
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
                message,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () {
                  formNotifier.startEditing();
                },
                child: const Text('再試行'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  /// 戻るナビゲーション処理
  void _handleBackNavigation(BuildContext context, bool hasChanges) {
    if (hasChanges) {
      showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('変更を破棄'),
          content: const Text('保存していない変更があります。破棄して戻りますか？'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('キャンセル'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.pop();
              },
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
                foregroundColor: Theme.of(context).colorScheme.onError,
              ),
              child: const Text('破棄'),
            ),
          ],
        ),
      );
    } else {
      context.pop();
    }
  }
  
  /// メモの共有
  Future<void> _shareNote(BuildContext context, NoteEntity? note) async {
    if (note == null) return;
    
    // TODO: Share機能の実装
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('共有機能は準備中です')),
    );
  }
  
  /// メモのコピー
  Future<void> _copyNote(BuildContext context, NoteEntity? note) async {
    if (note == null) return;
    
    // TODO: クリップボードにコピー
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('メモをコピーしました')),
    );
  }
  
  /// メモの削除
  Future<void> _deleteNote(BuildContext context, WidgetRef ref, NoteEntity note) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('メモを削除'),
        content: Text('「${note.title}」を削除しますか？\nこの操作は元に戻せません。'),
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
    
    if (confirmed == true) {
      final formNotifier = ref.read(noteFormNotifierProvider.notifier);
      final listNotifier = ref.read(noteListNotifierProvider.notifier);
      
      await formNotifier.deleteNote(note.id);
      await listNotifier.loadNotes(isRefresh: true);
      
      if (context.mounted) {
        context.pop(); // 詳細画面を閉じる
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('メモを削除しました')),
        );
      }
    }
  }
}
