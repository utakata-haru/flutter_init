import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../1_atoms/note_form_field.dart';

/// メモ作成・編集フォームコンポーネント
/// 
/// タイトルと内容の入力フィールド、保存・キャンセルボタンを組み合わせた
/// 完全なメモ編集機能を提供するフォーム
class NoteForm extends HookWidget {
  const NoteForm({
    super.key,
    this.initialTitle = '',
    this.initialContent = '',
    this.onSave,
    this.onCancel,
    this.onChanged,
    this.isEditing = false,
    this.isLoading = false,
    this.enabled = true,
    this.validationErrors = const [],
  });

  /// 初期タイトル
  final String initialTitle;
  
  /// 初期内容
  final String initialContent;
  
  /// 保存時のコールバック
  final Future<void> Function(String title, String content)? onSave;
  
  /// キャンセル時のコールバック
  final VoidCallback? onCancel;
  
  /// 入力変更時のコールバック
  final void Function(String title, String content)? onChanged;
  
  /// 編集モードかどうか
  final bool isEditing;
  
  /// ローディング状態かどうか
  final bool isLoading;
  
  /// フォームが有効かどうか
  final bool enabled;
  
  /// バリデーションエラー一覧
  final List<String> validationErrors;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    // テキストコントローラー
    final titleController = useTextEditingController(text: initialTitle);
    final contentController = useTextEditingController(text: initialContent);
    
    // 保存状態の管理
    final isSaving = useState(false);
    
    // 入力変更の監視
    useEffect(() {
      void handleChange() {
        onChanged?.call(titleController.text, contentController.text);
      }
      
      titleController.addListener(handleChange);
      contentController.addListener(handleChange);
      
      return () {
        titleController.removeListener(handleChange);
        contentController.removeListener(handleChange);
      };
    }, []);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // エラー表示
        if (validationErrors.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: colorScheme.errorContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'エラーが発生しました',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: colorScheme.onErrorContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ...validationErrors.map((error) => Text(
                  '• $error',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onErrorContainer,
                  ),
                )),
              ],
            ),
          ),
        
        // タイトルフィールド
        NoteTitleField(
          controller: titleController,
          enabled: enabled && !isLoading,
          autofocus: !isEditing,
        ),
        
        const SizedBox(height: 16),
        
        // 内容フィールド
        Expanded(
          child: NoteContentField(
            controller: contentController,
            enabled: enabled && !isLoading,
          ),
        ),
        
        const SizedBox(height: 16),
        
        // アクションボタン
        Row(
          children: [
            // キャンセルボタン
            if (onCancel != null) ...[
              Expanded(
                child: OutlinedButton(
                  onPressed: enabled && !isSaving.value ? onCancel : null,
                  child: const Text('キャンセル'),
                ),
              ),
              const SizedBox(width: 16),
            ],
            
            // 保存ボタン
            Expanded(
              flex: 2,
              child: FilledButton(
                onPressed: enabled && !isSaving.value && _isValidInput(titleController, contentController)
                    ? () => _handleSave(isSaving, titleController, contentController)
                    : null,
                child: isSaving.value 
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(isEditing ? '更新' : '保存'),
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  /// 入力値の検証
  bool _isValidInput(TextEditingController titleController, TextEditingController contentController) {
    return titleController.text.trim().isNotEmpty && 
           contentController.text.trim().isNotEmpty;
  }
  
  /// 保存処理
  Future<void> _handleSave(
    ValueNotifier<bool> isSaving,
    TextEditingController titleController,
    TextEditingController contentController,
  ) async {
    final title = titleController.text.trim();
    final content = contentController.text.trim();
    
    if (title.isEmpty || content.isEmpty || isSaving.value || !enabled) return;
    
    isSaving.value = true;
    try {
      await onSave?.call(title, content);
    } catch (e) {
      // エラーハンドリングは親コンポーネントで行う
      rethrow;
    } finally {
      isSaving.value = false;
    }
  }
}
