import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutter_init_3/core/routing/path/routine_settings_path.dart';
import 'package:flutter_init_3/features/user/routine_status/3_application/1_states/routine_dashboard_state.dart';
import 'package:flutter_init_3/features/user/routine_status/3_application/3_notifiers/routine_dashboard_notifier.dart';
import 'package:flutter_init_3/features/user/routine_status/4_presentation/1_widgets/3_organisms/routine_status_list_view.dart';

class RoutineDashboardPage extends HookConsumerWidget {
  const RoutineDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(routineDashboardProvider);
    final notifier = ref.read(routineDashboardProvider.notifier);

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
            onDelete: (routine) {
              _confirmDelete(context, notifier, routine.id);
            },
          );
        },
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
}
