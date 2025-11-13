import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutter_init_3/features/user/routine_status/1_domain/1_entities/routine_entity.dart';
import 'package:flutter_init_3/features/user/routine_status/3_application/2_providers/routine_threshold_provider.dart';
import 'package:flutter_init_3/features/user/routine_status/4_presentation/1_widgets/1_atoms/status_indicator.dart';

class RoutineStatusHelpPage extends HookConsumerWidget {
  const RoutineStatusHelpPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thresholdsAsync = ref.watch(routineThresholdProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('ステータスの見方')),
      body: SafeArea(
        child: thresholdsAsync.when(
          data: (thresholds) => _HelpContent(thresholds: thresholds),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => _ErrorView(
            message: '閾値情報の取得に失敗しました。',
            onRetry: () => ref.invalidate(routineThresholdProvider),
          ),
        ),
      ),
    );
  }
}

class _HelpContent extends StatelessWidget {
  const _HelpContent({required this.thresholds});

  final RoutineThresholdSetting thresholds;

  @override
  Widget build(BuildContext context) {
    final warningRangeStart = thresholds.allowableDelayMinutes + 1;
    final lateRangeStart = thresholds.criticalDelayMinutes + 1;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _SectionTitle('全体ステータスカード'),
        const SizedBox(height: 8),
        _LegendCard(
          backgroundColor: Colors.green.shade600,
          textColor: Colors.white,
          icon: Icons.check_circle,
          iconColor: Colors.green.shade900,
          title: 'オンタイム',
          description:
              '全体的にオンタイムなら、緑背景に白文字の「オンタイム」と緑のチェックマークで表示します（遅延が${thresholds.allowableDelayMinutes}分以内）。',
        ),
        const SizedBox(height: 12),
        _LegendCard(
          backgroundColor: Colors.amber.shade600,
          textColor: Colors.black87,
          icon: Icons.warning_amber_rounded,
          iconColor: Colors.amber.shade900,
          title: '遅延',
          description:
              '全体的に遅延気味なら、黄色背景に「遅延」と注意マーク（三角）で表示します（遅延が$warningRangeStart～${thresholds.criticalDelayMinutes}分程度）。',
        ),
        const SizedBox(height: 12),
        _LegendCard(
          backgroundColor: Colors.red.shade600,
          textColor: Colors.white,
          icon: Icons.close_rounded,
          iconColor: Colors.red.shade900,
          title: '乱れています',
          description:
              '全体的に乱れていたら、赤背景に「乱れています」とバツ印で警告します（遅延が$lateRangeStart分以上の場合）。',
        ),
        const SizedBox(height: 24),
        const _SectionTitle('個別カードのステータスアイコン'),
        const SizedBox(height: 8),
        const _IndicatorLegend(),
        const SizedBox(height: 24),
        const _SectionTitle('閾値の基準'),
        const SizedBox(height: 8),
        _ThresholdTile(
          icon: Icons.timer_outlined,
          title: 'オンタイム判定',
          description: '完了時刻が目標から${thresholds.allowableDelayMinutes}分以内ならオンタイムです。',
        ),
        const SizedBox(height: 12),
        _ThresholdTile(
          icon: Icons.error_outline,
          title: '注意レベル',
          description: '遅延が$warningRangeStart～${thresholds.criticalDelayMinutes}分なら注意表示になります。',
        ),
        const SizedBox(height: 12),
        _ThresholdTile(
          icon: Icons.close,
          title: '大幅遅延',
          description: '${thresholds.criticalDelayMinutes}分を超える遅延は赤色で強調表示します。',
        ),
      ],
    );
  }
}

class _LegendCard extends StatelessWidget {
  const _LegendCard({
    required this.backgroundColor,
    required this.textColor,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
  });

  final Color backgroundColor;
  final Color textColor;
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            foregroundColor: iconColor,
            child: Icon(icon),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.titleSmall?.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: textTheme.bodySmall?.copyWith(color: textColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _IndicatorLegend extends StatelessWidget {
  const _IndicatorLegend();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _IndicatorRow(status: RoutineComplianceStatus.onTime, label: 'オンタイム'),
        SizedBox(height: 8),
        _IndicatorRow(status: RoutineComplianceStatus.warning, label: '注意'),
        SizedBox(height: 8),
        _IndicatorRow(status: RoutineComplianceStatus.late, label: '遅延'),
      ],
    );
  }
}

class _IndicatorRow extends StatelessWidget {
  const _IndicatorRow({required this.status, required this.label});

  final RoutineComplianceStatus status;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StatusIndicator(status: status, showLabel: true),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}

class _ThresholdTile extends StatelessWidget {
  const _ThresholdTile({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: theme.colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: onRetry,
            child: const Text('再試行'),
          ),
        ],
      ),
    );
  }
}
