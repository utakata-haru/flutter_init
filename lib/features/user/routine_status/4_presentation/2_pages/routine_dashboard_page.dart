import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutter_init_3/core/routing/path/routine_settings_path.dart';
import 'package:flutter_init_3/core/routing/path/routine_status_help_path.dart';
import 'package:flutter_init_3/features/user/routine_status/1_domain/1_entities/routine_entity.dart';
import 'package:flutter_init_3/features/user/routine_status/3_application/1_states/routine_dashboard_state.dart';
import 'package:flutter_init_3/features/user/routine_status/3_application/3_notifiers/routine_dashboard_notifier.dart';
import 'package:flutter_init_3/features/user/routine_status/4_presentation/1_widgets/3_organisms/routine_status_list_view.dart';
import 'package:flutter_init_3/features/user/routine_status/3_application/2_providers/routine_repository_provider.dart';

class RoutineDashboardPage extends HookConsumerWidget {
  const RoutineDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(routineDashboardProvider);
    final notifier = ref.read(routineDashboardProvider.notifier);
    final theme = Theme.of(context);
    final nextRoutine = _findNextIncompleteRoutine(state.routines);
    final canQuickComplete = nextRoutine != null;
    final quickCompleteLabel = nextRoutine != null
        ? '${nextRoutine.name}を完了として記録'
        : '完了すべきルーチンはありません';

    useEffect(() {
      Future.microtask(() => notifier.refresh());
      return null;
    }, const []);

    ref.listen<RoutineDashboardState>(routineDashboardProvider, (
      previous,
      next,
    ) {
      final message = next.errorMessage;
      final previousMessage = previous?.errorMessage;
      if (message != null && message != previousMessage) {
        _showSnackBar(context, SnackBar(content: Text(message)));
        notifier.clearError();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('ルーチンダッシュボード'),
        actions: [
          IconButton(
            tooltip: '設定',
            icon: const Icon(Icons.tune),
            onPressed: () => context.pushNamed(routineSettingsRouteName),
          ),
          IconButton(
            tooltip: 'ヘルプ',
            icon: const Icon(Icons.help_outline),
            onPressed: () => context.pushNamed(routineStatusHelpRouteName),
          ),
          IconButton(
            tooltip: '完了履歴を初期化',
            icon: const Icon(Icons.delete_forever),
            onPressed: () => _confirmResetAll(context, notifier),
          ),
          IconButton(
            tooltip: '再読み込み',
            icon: const Icon(Icons.refresh),
            onPressed: () => notifier.refresh(),
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          if (state.isLoading && !state.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.checklist_rtl, size: 48),
                  const SizedBox(height: 12),
                  const Text('登録済みのルーチンがありません'),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () => notifier.refresh(),
                    child: const Text('更新'),
                  ),
                ],
              ),
            );
          }

          return RoutineStatusListView(
            routines: state.routines,
            thresholds: state.thresholds,
            onRefresh: notifier.refresh,
            onComplete: notifier.completeRoutine,
            onUndo: notifier.undoCompletion,
            onEditCompletionTime: (routine) =>
                _pickAndUpdateCompletion(context, ref, routine),
          );
        },
      ),
      bottomNavigationBar: state.routines.isEmpty
          ? null
          : SafeArea(
              minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: SizedBox(
                width: double.infinity,
                height: 72,
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    minimumSize: const Size.fromHeight(64),
                    textStyle: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: canQuickComplete
                      ? () => _completeNextRoutine(context, notifier, state)
                      : null,
                  icon: const Icon(Icons.playlist_add_check, size: 28),
                  label: Text(quickCompleteLabel),
                ),
              ),
            ),
    );
  }

  Future<void> _confirmResetAll(
    BuildContext context,
    RoutineDashboardNotifier notifier,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('完了記録をすべて初期化しますか？'),
        content: const Text('全ルーチンの完了履歴を削除して未完了状態に戻します。この操作は元に戻せません。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('キャンセル'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('初期化する'),
          ),
        ],
      ),
    );

    if (confirmed != true) {
      return;
    }

    final success = await notifier.resetAllCompletions();
    if (!context.mounted) {
      return;
    }

    if (success) {
      _showSnackBar(
        context,
        const SnackBar(content: Text('全てのルーチンを未完了状態に戻しました')),
      );
    }
  }

  Future<void> _completeNextRoutine(
    BuildContext context,
    RoutineDashboardNotifier notifier,
    RoutineDashboardState state,
  ) async {
    final target = _findNextIncompleteRoutine(state.routines);
    if (target == null) {
      _showSnackBar(
        context,
        const SnackBar(
          duration: Duration(seconds: 2),
          content: Text('完了すべきルーチンはありません。'),
        ),
      );
      return;
    }

    await notifier.completeRoutine(target, completedAt: DateTime.now());
    if (!context.mounted) {
      return;
    }

    _showSnackBar(
      context,
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Text('${target.name}を完了として記録しました'),
      ),
    );
  }

  RoutineEntity? _findNextIncompleteRoutine(List<RoutineEntity> routines) {
    if (routines.isEmpty) {
      return null;
    }

    final sorted = [...routines]
      ..sort((a, b) {
        final hourCompare = a.targetTime.hour.compareTo(b.targetTime.hour);
        if (hourCompare != 0) {
          return hourCompare;
        }
        return a.targetTime.minute.compareTo(b.targetTime.minute);
      });

    for (final routine in sorted) {
      if (routine.lastResult == null) {
        return routine;
      }
    }

    return null;
  }

  Future<void> _pickAndUpdateCompletion(
    BuildContext context,
    WidgetRef ref,
    RoutineEntity routine,
  ) async {
    final initial = routine.lastResult?.completedAt ?? DateTime.now();
    final initialTime = TimeOfDay(hour: initial.hour, minute: initial.minute);

    final picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) => child ?? const SizedBox.shrink(),
    );
    if (picked == null) {
      return;
    }

    final newCompletedAt = DateTime(
      initial.year,
      initial.month,
      initial.day,
      picked.hour,
      picked.minute,
    );

    final useCase = ref.read(updateCompletionTimeUseCaseProvider);
    try {
      await useCase(routine: routine, newCompletedAt: newCompletedAt);
      if (!context.mounted) return;
      _showSnackBar(
        context,
        const SnackBar(
          duration: Duration(seconds: 2),
          content: Text('完了時刻を更新しました（編集済み）'),
        ),
      );
    } catch (e) {
      if (!context.mounted) return;
      _showSnackBar(context, SnackBar(content: Text(e.toString())));
    }
  }

  void _showSnackBar(BuildContext context, SnackBar snackBar) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.clearSnackBars();
    messenger.showSnackBar(snackBar);
  }
}
