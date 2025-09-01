import 'package:flutter/material.dart';
import '../../../1_domain/1_entities/note_entity.dart';

/// メモの基本タイル表示コンポーネント
/// 
/// メモのタイトル、内容（一部）、作成・更新日時を表示する
/// 最も基本的なメモ表示単位として使用される
class NoteTile extends StatelessWidget {
  const NoteTile({
    super.key,
    required this.note,
    this.onTap,
    this.isSelected = false,
    this.showFullContent = false,
    this.maxLines = 2,
    this.contentMaxLength = 100,
  });

  /// 表示するメモエンティティ
  final NoteEntity note;
  
  /// タップ時のコールバック
  final VoidCallback? onTap;
  
  /// 選択状態かどうか
  final bool isSelected;
  
  /// 内容を全て表示するかどうか
  final bool showFullContent;
  
  /// 内容の最大行数
  final int maxLines;
  
  /// 内容の最大文字数
  final int contentMaxLength;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    // 内容のテキストを準備
    final displayContent = showFullContent 
        ? note.content
        : _truncateContent(note.content, contentMaxLength);
    
    return Material(
      color: isSelected 
          ? colorScheme.primaryContainer.withValues(alpha: 0.3)
          : Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ヘッダー行（タイトル）
              Row(
                children: [
                  // タイトル
                  Expanded(
                    child: Text(
                      note.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              
              // 内容
              if (displayContent.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  displayContent,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
                    height: 1.4,
                  ),
                  maxLines: showFullContent ? null : maxLines,
                  overflow: showFullContent ? null : TextOverflow.ellipsis,
                ),
              ],
              
              // フッター（更新日時とステータス）
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 更新日時
                  Text(
                    _formatDate(note.updatedAt),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                    ),
                  ),
                  
                  // ステータスインジケータ
                  _buildStatusIndicator(context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ステータスインジケータを構築
  Widget _buildStatusIndicator(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 文字数インジケータ
        if (note.content.length > 500) ...[
          Icon(
            Icons.description,
            size: 12,
            color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
          ),
          const SizedBox(width: 4),
        ],
        
        // 更新インジケータ
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _getStatusColor(colorScheme),
          ),
        ),
      ],
    );
  }

  /// ステータスに応じた色を取得
  Color _getStatusColor(ColorScheme colorScheme) {
    final now = DateTime.now();
    final difference = now.difference(note.updatedAt);
    
    if (difference.inDays < 1) {
      return colorScheme.primary.withValues(alpha: 0.7); // 最近更新
    } else if (difference.inDays < 7) {
      return colorScheme.secondary.withValues(alpha: 0.7); // 今週更新
    } else {
      return colorScheme.onSurfaceVariant.withValues(alpha: 0.4); // 古い
    }
  }

  /// テキストを指定された長さで切り詰める
  String _truncateContent(String content, int maxLength) {
    if (content.length <= maxLength) {
      return content;
    }
    
    // 改行を除去し、指定の長さで切り詰める
    final cleanContent = content.replaceAll(RegExp(r'\s+'), ' ').trim();
    if (cleanContent.length <= maxLength) {
      return cleanContent;
    }
    
    return '${cleanContent.substring(0, maxLength)}...';
  }

  /// 日付をフォーマット
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
      return '${dateTime.month}/${dateTime.day}';
    }
  }
}

/// コンパクトなメモタイル（リスト表示用）
class CompactNoteTile extends StatelessWidget {
  const CompactNoteTile({
    super.key,
    required this.note,
    this.onTap,
    this.isSelected = false,
  });

  final NoteEntity note;
  final VoidCallback? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Material(
      color: isSelected 
          ? colorScheme.primaryContainer.withValues(alpha: 0.2)
          : Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              // メイン内容
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // タイトル
                    Text(
                      note.title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    // 内容プレビュー
                    if (note.content.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        note.content.replaceAll(RegExp(r'\s+'), ' '),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              
              // 更新日時
              const SizedBox(width: 12),
              Text(
                _formatDate(note.updatedAt),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 日付をフォーマット
  String _formatDate(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}分';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}時間';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}日';
    } else {
      return '${dateTime.month}/${dateTime.day}';
    }
  }
}
