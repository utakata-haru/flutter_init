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
    this.onDelete,
  });

  final List<RoutineEntity> routines;
  final RoutineThresholdSetting? thresholds;
  final Future<void> Function() onRefresh;
  final void Function(RoutineEntity routine)? onTap;
  final void Function(RoutineEntity routine)? onComplete;
  final void Function(RoutineEntity routine)? onDelete;

  @override
  Widget build(BuildContext context) {
    final hasSummary = thresholds != null;
    final totalCount = routines.length + (hasSummary ? 1 : 0);

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        itemBuilder: (context, index) {
          if (hasSummary && index == 0) {
            return _ThresholdSummaryCard(setting: thresholds!);
          }

          final routineIndex = hasSummary ? index - 1 : index;
          final routine = routines[routineIndex];

          return RoutineCard(
            routine: routine,
            onTap: onTap == null ? null : () => onTap!(routine),
            onComplete: onComplete == null ? null : () => onComplete!(routine),
            onDelete: onDelete == null ? null : () => onDelete!(routine),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemCount: totalCount,
      ),
    );
  }
}

class _ThresholdSummaryCard extends StatelessWidget {
  const _ThresholdSummaryCard({required this.setting});

  final RoutineThresholdSetting setting;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainerHigh,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _ThresholdValue(
              label: 'オンタイム判定',
              minutes: setting.allowableDelayMinutes,
              color: theme.colorScheme.primary,
            ),
            _ThresholdValue(
              label: '警告判定',
              minutes: setting.criticalDelayMinutes,
              color: theme.colorScheme.tertiary,
            ),
          ],
        ),
      ),
    );
  }
}

class _ThresholdValue extends StatelessWidget {
  const _ThresholdValue({
    required this.label,
    required this.minutes,
    required this.color,
  });

  final String label;
  final int minutes;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(Icons.timer_outlined, size: 18, color: color),
            const SizedBox(width: 6),
            Text(
              '$minutes 分以内',
              style: theme.textTheme.bodyMedium?.copyWith(color: color),
            ),
          ],
        ),
      ],
    );
  }
}
