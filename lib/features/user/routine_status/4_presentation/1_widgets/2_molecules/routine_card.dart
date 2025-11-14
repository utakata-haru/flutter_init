import 'package:flutter/material.dart';

import 'package:flutter_init_3/features/user/routine_status/1_domain/1_entities/routine_entity.dart';
import 'package:flutter_init_3/features/user/routine_status/4_presentation/1_widgets/1_atoms/status_indicator.dart';

class RoutineCard extends StatelessWidget {
  const RoutineCard({
    super.key,
    required this.routine,
    this.onTap,
    this.onComplete,
    this.onUndo,
    this.onEdit,
    this.onDelete,
    this.onMoveUp,
    this.onMoveDown,
    this.showLastResult = true,
    this.showStatusIndicator = true,
  });

  final RoutineEntity routine;
  final VoidCallback? onTap;
  final VoidCallback? onComplete;
  final VoidCallback? onUndo;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onMoveUp;
  final VoidCallback? onMoveDown;
  final bool showLastResult;
  final bool showStatusIndicator;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasResult = routine.lastResult != null;
    final status = routine.lastResult?.status ?? RoutineComplianceStatus.onTime;
    final targetTime = _formatTime(
      routine.targetTime.hour,
      routine.targetTime.minute,
    );
    final lastResultText = showLastResult ? _buildLastResultText() : null;
    final indicator = showStatusIndicator && hasResult
        ? StatusIndicator(status: status)
        : CircleAvatar(
            radius: 16,
            backgroundColor: theme.colorScheme.surfaceContainerHigh,
            child: Icon(
              Icons.schedule,
              size: 18,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          );
    final actionCallback = hasResult ? onUndo : onComplete;
    final actionLabel = hasResult ? '完了を取り消す' : '完了として記録';
    final actionIcon = hasResult
        ? const Icon(Icons.undo)
        : const Icon(Icons.check_circle_outline);
    final showReorderControls = onMoveUp != null || onMoveDown != null;
    final showEdit = onEdit != null;
    final showDelete = onDelete != null;

    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  indicator,
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          routine.name,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '目標時刻: $targetTime',
                          style: theme.textTheme.bodyMedium,
                        ),
                        if (lastResultText != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            lastResultText,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (showReorderControls)
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          tooltip: '上に移動',
                          icon: const Icon(Icons.arrow_upward),
                          onPressed: onMoveUp,
                        ),
                        IconButton(
                          tooltip: '下に移動',
                          icon: const Icon(Icons.arrow_downward),
                          onPressed: onMoveDown,
                        ),
                      ],
                    ),
                  if (showReorderControls && (showEdit || showDelete))
                    const SizedBox(width: 4),
                  if (onEdit != null)
                    IconButton(
                      tooltip: '編集',
                      icon: const Icon(Icons.edit_outlined),
                      onPressed: onEdit,
                    ),
                  if (onDelete != null)
                    IconButton(
                      tooltip: '削除',
                      icon: const Icon(Icons.delete_outline),
                      onPressed: onDelete,
                    ),
                ],
              ),
              if (actionCallback != null) ...[
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: FilledButton.icon(
                    onPressed: actionCallback,
                    icon: actionIcon,
                    label: Text(actionLabel),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _buildLastResultText() {
    final result = routine.lastResult;
    if (result == null) {
      return 'まだ完了記録がありません';
    }

    final completedAt = result.completedAt;
    final completedText =
        '${completedAt.year}/${_twoDigits(completedAt.month)}/${_twoDigits(completedAt.day)} ${_twoDigits(completedAt.hour)}:${_twoDigits(completedAt.minute)}';
    final delay = result.delayMinutes;

    if (delay == 0) {
      return '最終完了: $completedText（オンタイム）';
    }

    return '最終完了: $completedText（+$delay 分）';
  }

  String _formatTime(int hour, int minute) =>
      '${_twoDigits(hour)}:${_twoDigits(minute)}';

  String _twoDigits(int value) => value.toString().padLeft(2, '0');
}
