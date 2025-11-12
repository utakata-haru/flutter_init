import 'package:flutter/material.dart';

import 'package:flutter_init_3/features/user/routine_status/1_domain/1_entities/routine_entity.dart';

/// Compact visual indicator for a routine's compliance status.
class StatusIndicator extends StatelessWidget {
  const StatusIndicator({
    super.key,
    required this.status,
    this.showLabel = false,
  });

  final RoutineComplianceStatus status;
  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final indicatorColor = _statusColor(colorScheme);
    final iconData = _statusIcon();

    final indicator = CircleAvatar(
      radius: 16,
      backgroundColor: indicatorColor,
      child: Icon(iconData, size: 18, color: colorScheme.onPrimary),
    );

    if (!showLabel) {
      return indicator;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        indicator,
        const SizedBox(width: 8),
        Text(_statusLabel(), style: Theme.of(context).textTheme.labelMedium),
      ],
    );
  }

  Color _statusColor(ColorScheme scheme) {
    switch (status) {
      case RoutineComplianceStatus.onTime:
        return scheme.primary;
      case RoutineComplianceStatus.warning:
        return scheme.tertiary;
      case RoutineComplianceStatus.late:
        return scheme.error;
    }
  }

  IconData _statusIcon() {
    switch (status) {
      case RoutineComplianceStatus.onTime:
        return Icons.check_rounded;
      case RoutineComplianceStatus.warning:
        return Icons.warning_amber_rounded;
      case RoutineComplianceStatus.late:
        return Icons.close_rounded;
    }
  }

  String _statusLabel() {
    switch (status) {
      case RoutineComplianceStatus.onTime:
        return 'オンタイム';
      case RoutineComplianceStatus.warning:
        return '注意';
      case RoutineComplianceStatus.late:
        return '警告';
    }
  }
}
