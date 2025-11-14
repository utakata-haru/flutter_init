import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutter_init_3/core/routing/path/routine_settings_path.dart';
import 'package:flutter_init_3/core/routing/path/routine_status_help_path.dart';
import 'package:flutter_init_3/features/user/routine_status/1_domain/1_entities/routine_entity.dart';
import 'package:flutter_init_3/features/user/routine_status/3_application/1_states/routine_dashboard_state.dart';
import 'package:flutter_init_3/features/user/routine_status/3_application/3_notifiers/routine_dashboard_notifier.dart';
import 'package:flutter_init_3/features/user/routine_status/4_presentation/1_widgets/3_organisms/routine_editor_sheet.dart';
import 'package:flutter_init_3/features/user/routine_status/4_presentation/1_widgets/3_organisms/routine_status_list_view.dart';

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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
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
            onEdit: (routine) => _openRoutineEditor(
              context,
              ref,
              state,
              notifier,
              existing: routine,
            ),
            onDelete: (routine) {
              _confirmDelete(context, notifier, routine.id);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openRoutineEditor(context, ref, state, notifier),
        icon: const Icon(Icons.add),
        label: const Text('ルーチン追加'),
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

  void _confirmDelete(
    BuildContext context,
    RoutineDashboardNotifier notifier,
    String routineId,
  ) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ルーチンを削除しますか？'),
        content: const Text('この操作は元に戻せません。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              notifier.deleteRoutine(routineId);
            },
            child: const Text('削除'),
          ),
        ],
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('全てのルーチンを未完了状態に戻しました')));
    }
  }

  Future<void> _openRoutineEditor(
    BuildContext context,
    WidgetRef ref,
    RoutineDashboardState state,
    RoutineDashboardNotifier notifier, {
    RoutineEntity? existing,
  }) async {
    final thresholds = state.thresholds ?? const RoutineThresholdSetting();
    final routine = await showRoutineEditorSheet(
      context: context,
      defaultThresholds: thresholds,
      existing: existing,
    );

    if (routine == null) {
      return;
    }

    final success = await notifier.saveRoutine(routine);
    if (!context.mounted) {
      return;
    }

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            existing == null
                ? '${routine.name}を追加しました'
                : '${routine.name}を更新しました',
          ),
        ),
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('完了すべきルーチンはありません。')));
      return;
    }

    await notifier.completeRoutine(target, completedAt: DateTime.now());
    if (!context.mounted) {
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('${target.name}を完了として記録しました')));
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
}
