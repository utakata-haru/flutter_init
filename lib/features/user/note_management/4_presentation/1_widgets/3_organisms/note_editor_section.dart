import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../1_domain/1_entities/note_entity.dart';
import '../2_molecules/note_form.dart';

/// メモ編集セクションオーガニズム
/// 
/// メモの作成・編集機能を提供する完全なセクション
/// フォーム、プレビュー、ツールバーを統合した編集環境
class NoteEditorSection extends HookWidget {
  const NoteEditorSection({
    super.key,
    this.note,
    this.initialTitle = '',
    this.initialContent = '',
    this.onSave,
    this.onCancel,
    this.onDelete,
    this.onPreviewToggle,
    this.isLoading = false,
    this.autoSave = false,
    this.showPreview = false,
    this.showToolbar = true,
    this.validationErrors = const [],
  });

  /// 編集対象のメモ（新規作成時はnull）
  final NoteEntity? note;
  
  /// 初期タイトル
  final String initialTitle;
  
  /// 初期内容
  final String initialContent;
  
  /// 保存時のコールバック
  final Future<void> Function(String title, String content)? onSave;
  
  /// キャンセル時のコールバック
  final VoidCallback? onCancel;
  
  /// 削除時のコールバック
  final VoidCallback? onDelete;
  
  /// プレビュー切り替え時のコールバック
  final void Function(bool showPreview)? onPreviewToggle;
  
  /// ローディング状態
  final bool isLoading;
  
  /// 自動保存するかどうか
  final bool autoSave;
  
  /// プレビューを表示するかどうか
  final bool showPreview;
  
  /// ツールバーを表示するかどうか
  final bool showToolbar;
  
  /// バリデーションエラー一覧
  final List<String> validationErrors;

  @override
  Widget build(BuildContext context) {
    Theme.of(context);
    
    // 編集モードかどうか
    final isEditing = note != null;
    
    // 現在のタイトルと内容
    final currentTitle = useState(note?.title ?? initialTitle);
    final currentContent = useState(note?.content ?? initialContent);
    
    return Column(
      children: [
        // ツールバー
        if (showToolbar)
          _buildToolbar(context, isEditing),
        
        // メインエディター
        Expanded(
          child: showPreview 
              ? _buildPreviewSection(context, currentTitle.value, currentContent.value)
              : _buildEditorSection(context, isEditing, currentTitle, currentContent),
        ),
      ],
    );
  }
  
  /// ツールバー構築
  Widget _buildToolbar(BuildContext context, bool isEditing) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // メタデータ表示
          if (isEditing && note != null) ...[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '最終更新: ${_formatDate(note!.updatedAt)}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    '作成日: ${_formatDate(note!.createdAt)}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            Expanded(
              child: Text(
                '新しいメモ',
                style: theme.textTheme.titleMedium,
              ),
            ),
          ],
          
          // アクションボタン
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // プレビュー切り替えボタン
              IconButton(
                onPressed: () {
                  onPreviewToggle?.call(!showPreview);
                },
                icon: Icon(showPreview ? Icons.edit : Icons.preview),
                tooltip: showPreview ? '編集モード' : 'プレビューモード',
              ),
              
              // 削除ボタン（編集時のみ）
              if (isEditing && onDelete != null) ...[
                const SizedBox(width: 8),
                IconButton(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete_outline),
                  tooltip: '削除',
                  style: IconButton.styleFrom(
                    foregroundColor: colorScheme.error,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
  
  /// エディターセクション構築
  Widget _buildEditorSection(
    BuildContext context,
    bool isEditing,
    ValueNotifier<String> currentTitle,
    ValueNotifier<String> currentContent,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: NoteForm(
        initialTitle: currentTitle.value,
        initialContent: currentContent.value,
        onSave: onSave,
        onCancel: onCancel,
        onChanged: (title, content) {
          currentTitle.value = title;
          currentContent.value = content;
        },
        isEditing: isEditing,
        isLoading: isLoading,
        validationErrors: validationErrors,
      ),
    );
  }
  
  /// プレビューセクション構築
  Widget _buildPreviewSection(BuildContext context, String title, String content) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // タイトルプレビュー
          if (title.isNotEmpty) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                title,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
          
          // 内容プレビュー
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: colorScheme.outline.withValues(alpha: 0.2),
                ),
              ),
              child: content.isNotEmpty
                  ? SingleChildScrollView(
                      child: Text(
                        content,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          height: 1.6,
                        ),
                      ),
                    )
                  : Center(
                      child: Text(
                        'プレビューする内容がありません',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
            ),
          ),
          
          // プレビューフッター
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 16,
                  color: colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'これはプレビューです。編集するには編集モードに切り替えてください。',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  /// 日付フォーマット
  String _formatDate(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inMinutes < 1) {
      return 'たった今';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}分前';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}時間前';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}日前';
    } else {
      return '${dateTime.year}/${dateTime.month}/${dateTime.day}';
    }
  }
}
