import 'package:flutter/material.dart';
import '../../../1_domain/1_entities/note_entity.dart';
import '../1_atoms/note_tile.dart';

/// メモカードコンポーネント
/// 
/// NoteTileにアクションボタン（編集、削除など）を組み合わせた
/// より機能的なメモ表示コンポーネント
class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.note,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.onShare,
    this.isSelected = false,
    this.showActions = true,
    this.variant = NoteCardVariant.standard,
    this.elevation = 1,
  });

  /// 表示するメモエンティティ
  final NoteEntity note;
  
  /// カードタップ時のコールバック
  final VoidCallback? onTap;
  
  /// 編集ボタンタップ時のコールバック
  final VoidCallback? onEdit;
  
  /// 削除ボタンタップ時のコールバック
  final VoidCallback? onDelete;
  
  /// 共有ボタンタップ時のコールバック
  final VoidCallback? onShare;
  
  /// 選択状態かどうか
  final bool isSelected;
  
  /// アクションボタンを表示するかどうか
  final bool showActions;
  
  /// カードのバリアント
  final NoteCardVariant variant;
  
  /// カードの影の高さ
  final double elevation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Card(
      elevation: isSelected ? elevation + 2 : elevation,
      margin: _getMargin(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isSelected 
            ? BorderSide(color: colorScheme.primary, width: 2)
            : BorderSide.none,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // メインコンテンツ（NoteTile）
          NoteTile(
            note: note,
            onTap: onTap,
            isSelected: false, // カード自体で選択状態を表現するため
            showFullContent: variant == NoteCardVariant.detailed,
            maxLines: _getMaxLines(),
            contentMaxLength: _getContentMaxLength(),
          ),
          
          // アクションバー
          if (showActions) ...[
            const Divider(height: 1),
            _buildActionBar(context),
          ],
        ],
      ),
    );
  }

  /// アクションバーを構築
  Widget _buildActionBar(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // 作成・更新情報（コンパクト表示時）
          if (variant == NoteCardVariant.compact) ...[
            Expanded(
              child: Text(
                _getCompactTimestamp(),
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
          ],
          
          // 共有ボタン
          if (onShare != null) ...[
            IconButton(
              onPressed: onShare,
              icon: const Icon(Icons.share_outlined),
              iconSize: 20,
              tooltip: '共有',
              visualDensity: VisualDensity.compact,
            ),
          ],
          
          // 編集ボタン
          if (onEdit != null) ...[
            IconButton(
              onPressed: onEdit,
              icon: const Icon(Icons.edit_outlined),
              iconSize: 20,
              tooltip: '編集',
              visualDensity: VisualDensity.compact,
            ),
          ],
          
          // 削除ボタン
          if (onDelete != null) ...[
            IconButton(
              onPressed: () => _showDeleteConfirmation(context),
              icon: const Icon(Icons.delete_outline),
              iconSize: 20,
              tooltip: '削除',
              visualDensity: VisualDensity.compact,
              color: colorScheme.error,
            ),
          ],
        ],
      ),
    );
  }

  /// 削除確認ダイアログを表示
  void _showDeleteConfirmation(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('メモを削除'),
        content: Text('「${note.title.isEmpty ? '無題のメモ' : note.title}」を削除しますか？\nこの操作は元に戻せません。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('キャンセル'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              onDelete?.call();
            },
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('削除'),
          ),
        ],
      ),
    );
  }

  /// バリアントに応じたマージンを取得
  EdgeInsets _getMargin() {
    switch (variant) {
      case NoteCardVariant.compact:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 4);
      case NoteCardVariant.detailed:
        return const EdgeInsets.all(16);
      case NoteCardVariant.standard:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
    }
  }

  /// バリアントに応じた最大行数を取得
  int _getMaxLines() {
    switch (variant) {
      case NoteCardVariant.compact:
        return 1;
      case NoteCardVariant.detailed:
        return 6;
      case NoteCardVariant.standard:
        return 3;
    }
  }

  /// バリアントに応じた内容最大文字数を取得
  int _getContentMaxLength() {
    switch (variant) {
      case NoteCardVariant.compact:
        return 50;
      case NoteCardVariant.detailed:
        return 300;
      case NoteCardVariant.standard:
        return 150;
    }
  }

  /// コンパクト表示用のタイムスタンプを取得
  String _getCompactTimestamp() {
    final now = DateTime.now();
    final difference = now.difference(note.updatedAt);
    
    if (difference.inMinutes < 1) {
      return 'たった今';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}分前';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}時間前';
    } else if (difference.inDays < 30) {
      return '${difference.inDays}日前';
    } else {
      return '${note.updatedAt.month}/${note.updatedAt.day}';
    }
  }
}

/// NoteCardのバリアント
enum NoteCardVariant {
  /// 標準表示
  standard,
  /// コンパクト表示
  compact,
  /// 詳細表示
  detailed,
}

/// 選択可能なメモカード
class SelectableNoteCard extends StatelessWidget {
  const SelectableNoteCard({
    super.key,
    required this.note,
    required this.isSelected,
    required this.onSelectionChanged,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.onShare,
    this.variant = NoteCardVariant.standard,
    this.selectionMode = false,
  });

  final NoteEntity note;
  final bool isSelected;
  final ValueChanged<bool> onSelectionChanged;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onShare;
  final NoteCardVariant variant;
  final bool selectionMode;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: selectionMode ? null : () => onSelectionChanged(!isSelected),
      child: NoteCard(
        note: note,
        onTap: selectionMode 
            ? () => onSelectionChanged(!isSelected)
            : onTap,
        onEdit: selectionMode ? null : onEdit,
        onDelete: selectionMode ? null : onDelete,
        onShare: selectionMode ? null : onShare,
        isSelected: isSelected,
        showActions: !selectionMode,
        variant: variant,
      ),
    );
  }
}

/// グリッド表示用のメモカード
class GridNoteCard extends StatelessWidget {
  const GridNoteCard({
    super.key,
    required this.note,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.onShare,
    this.isSelected = false,
    this.aspectRatio = 1.2,
  });

  final NoteEntity note;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onShare;
  final bool isSelected;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: NoteCard(
        note: note,
        onTap: onTap,
        onEdit: onEdit,
        onDelete: onDelete,
        onShare: onShare,
        isSelected: isSelected,
        variant: NoteCardVariant.compact,
        elevation: 2,
      ),
    );
  }
}

/// フローティング表示用のメモカード
class FloatingNoteCard extends StatelessWidget {
  const FloatingNoteCard({
    super.key,
    required this.note,
    this.onTap,
    this.onClose,
    this.position = FloatingPosition.bottomRight,
    this.width = 300,
    this.height = 200,
  });

  final NoteEntity note;
  final VoidCallback? onTap;
  final VoidCallback? onClose;
  final FloatingPosition position;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final positionProperties = position.getPositionProperties();
    
    return Positioned(
      top: positionProperties['top'],
      bottom: positionProperties['bottom'],
      left: positionProperties['left'],
      right: positionProperties['right'],
      child: Container(
        width: width,
        height: height,
        margin: const EdgeInsets.all(16),
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              NoteCard(
                note: note,
                onTap: onTap,
                showActions: false,
                variant: NoteCardVariant.detailed,
                elevation: 0,
              ),
              if (onClose != null)
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    onPressed: onClose,
                    icon: const Icon(Icons.close),
                    iconSize: 20,
                    style: IconButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.surface.withValues(alpha: 0.8),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// フローティングカードの位置
enum FloatingPosition {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
  center;

  Map<String, double?> getPositionProperties() {
    switch (this) {
      case FloatingPosition.topLeft:
        return {'top': 0, 'left': 0, 'bottom': null, 'right': null};
      case FloatingPosition.topRight:
        return {'top': 0, 'right': 0, 'bottom': null, 'left': null};
      case FloatingPosition.bottomLeft:
        return {'bottom': 0, 'left': 0, 'top': null, 'right': null};
      case FloatingPosition.bottomRight:
        return {'bottom': 0, 'right': 0, 'top': null, 'left': null};
      case FloatingPosition.center:
        return {'top': null, 'bottom': null, 'left': null, 'right': null}; // Centerウィジェットで配置
    }
  }
}
