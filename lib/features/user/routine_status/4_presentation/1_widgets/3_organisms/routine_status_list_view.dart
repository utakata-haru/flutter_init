import 'package:flutter/material.dart';

import 'package:flutter_init_3/features/user/routine_status/1_domain/1_entities/routine_entity.dart';
import 'package:flutter_init_3/features/user/routine_status/4_presentation/1_widgets/2_molecules/routine_card.dart';

class RoutineStatusListView extends StatelessWidget {
  const RoutineStatusListView({
    super.key,
    required this.routines,
    this.thresholds,
    required this.onRefresh,
    this.onTap,
    this.onComplete,
    this.onUndo,
    this.onEdit,
    this.onDelete,
  });

  final List<RoutineEntity> routines;
  final RoutineThresholdSetting? thresholds;
  final Future<void> Function() onRefresh;
  final void Function(RoutineEntity routine)? onTap;
  final void Function(RoutineEntity routine)? onComplete;
  final void Function(RoutineEntity routine)? onUndo;
  final void Function(RoutineEntity routine)? onEdit;
  final void Function(RoutineEntity routine)? onDelete;

  @override
  Widget build(BuildContext context) {
    final showOverallStatus = thresholds != null;
    final totalCount = routines.length + (showOverallStatus ? 1 : 0);

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        itemBuilder: (context, index) {
          if (showOverallStatus && index == 0) {
            return _OverallStatusCard(
              routines: routines,
              thresholds: thresholds!,
            );
          }

          final routineIndex = showOverallStatus ? index - 1 : index;
          final routine = routines[routineIndex];

          return RoutineCard(
            routine: routine,
            onTap: onTap == null ? null : () => onTap!(routine),
            onComplete: onComplete == null ? null : () => onComplete!(routine),
            onUndo: onUndo == null ? null : () => onUndo!(routine),
            onEdit: onEdit == null ? null : () => onEdit!(routine),
            onDelete: onDelete == null ? null : () => onDelete!(routine),
            showLastResult: true,
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemCount: totalCount,
      ),
    );
  }
}

class _OverallStatusCard extends StatelessWidget {
  const _OverallStatusCard({required this.routines, required this.thresholds});

  final List<RoutineEntity> routines;
  final RoutineThresholdSetting thresholds;

  @override
  Widget build(BuildContext context) {
    final data = _OverallStatusViewData.from(
      routines: routines,
      thresholds: thresholds,
    );
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 0,
      color: data.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              foregroundColor: data.iconColor,
              child: Icon(data.icon),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title,
                    style: textTheme.titleMedium?.copyWith(
                      color: data.textColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data.message,
                    style: textTheme.bodySmall?.copyWith(color: data.textColor),
                  ),
                  if (data.detail != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      data.detail!,
                      style: textTheme.bodySmall?.copyWith(
                        color: data.textColor,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum _AggregateLevel { onTime, warning, late }

class _OverallStatusViewData {
  const _OverallStatusViewData({
    required this.level,
    required this.backgroundColor,
    required this.textColor,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.message,
    this.detail,
  });

  final _AggregateLevel level;
  final Color backgroundColor;
  final Color textColor;
  final IconData icon;
  final Color iconColor;
  final String title;
  final String message;
  final String? detail;

  factory _OverallStatusViewData.from({
    required List<RoutineEntity> routines,
    required RoutineThresholdSetting thresholds,
  }) {
    var onTimeCount = 0;
    var warningCount = 0;
    var lateCount = 0;
    var pendingCount = 0;

    for (final routine in routines) {
      final status = routine.lastResult?.status;
      if (status == null) {
        pendingCount++;
        continue;
      }

      switch (status) {
        case RoutineComplianceStatus.onTime:
          onTimeCount++;
          break;
        case RoutineComplianceStatus.warning:
          warningCount++;
          break;
        case RoutineComplianceStatus.late:
          lateCount++;
          break;
      }
    }

    final hasAnyCompletion = onTimeCount + warningCount + lateCount > 0;

    final _AggregateLevel level;
    if (lateCount > 0) {
      level = _AggregateLevel.late;
    } else if (warningCount > 0) {
      level = _AggregateLevel.warning;
    } else {
      level = _AggregateLevel.onTime;
    }

    Color backgroundColor;
    Color textColor;
    Color iconColor;
    IconData icon;
    String title;
    String message;
    String? detail;

    switch (level) {
      case _AggregateLevel.onTime:
        backgroundColor = Colors.green.shade600;
        textColor = Colors.white;
        icon = Icons.check_circle;
        iconColor = Colors.green.shade900;
        title = 'オンタイム';
        if (hasAnyCompletion) {
          message = '全体的に予定どおりに進んでいます。';
          if (pendingCount > 0) {
            detail = '未記録のルーチン: $pendingCount件';
          }
        } else {
          message = 'まだ完了記録がありません。最初の完了を登録して状況を確認しましょう。';
          if (pendingCount > 0) {
            detail = '登録済みルーチン: $pendingCount件';
          }
        }
        break;
      case _AggregateLevel.warning:
        backgroundColor = Colors.amber.shade600;
        textColor = Colors.black87;
        icon = Icons.warning_amber_rounded;
        iconColor = Colors.amber.shade900;
        title = '遅延';
        message = '一部のルーチンが遅延気味です。早めに調整しましょう。';
        detail = '注意レベルの遅延: $warningCount件';
        if (lateCount > 0) {
          detail = '$detail／大幅遅延: $lateCount件';
        }
        if (pendingCount > 0) {
          detail = '$detail／未記録: $pendingCount件';
        }
        break;
      case _AggregateLevel.late:
        backgroundColor = Colors.red.shade600;
        textColor = Colors.white;
        icon = Icons.close_rounded;
        iconColor = Colors.red.shade900;
        title = '乱れています';
        message = '複数のルーチンで大幅な遅れが発生しています。至急見直しが必要です。';
        detail = '大幅遅延: $lateCount件';
        if (warningCount > 0) {
          detail = '$detail／注意レベル: $warningCount件';
        }
        if (pendingCount > 0) {
          detail = '$detail／未記録: $pendingCount件';
        }
        break;
    }

    return _OverallStatusViewData(
      level: level,
      backgroundColor: backgroundColor,
      textColor: textColor,
      icon: icon,
      iconColor: iconColor,
      title: title,
      message: message,
      detail: detail,
    );
  }
}
