import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutter_init_3/features/user/routine_status/1_domain/1_entities/routine_entity.dart';
import 'package:flutter_init_3/features/user/routine_status/3_application/1_states/routine_settings_state.dart';
import 'package:flutter_init_3/features/user/routine_status/3_application/3_notifiers/routine_settings_notifier.dart';
import 'package:flutter_init_3/features/user/routine_status/4_presentation/1_widgets/2_molecules/routine_card.dart';
import 'package:flutter_init_3/features/user/routine_status/4_presentation/1_widgets/3_organisms/routine_editor_sheet.dart';

class RoutineSettingsPage extends HookConsumerWidget {
  const RoutineSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(routineSettingsProvider);
    final notifier = ref.read(routineSettingsProvider.notifier);

    useEffect(() {
      Future.microtask(() => notifier.refresh());
      return null;
    }, const []);

    final formKey = useMemoized(GlobalKey<FormState>.new);
    final allowableController = useTextEditingController();
    final criticalController = useTextEditingController();

    useEffect(() {
      final setting = state.setting;
      if (setting != null) {
        allowableController.text = setting.allowableDelayMinutes.toString();
        criticalController.text = setting.criticalDelayMinutes.toString();
      }
      return null;
    }, [state.setting]);

    ref.listen<RoutineSettingsState>(routineSettingsProvider, (previous, next) {
      final messenger = ScaffoldMessenger.of(context);
      final error = next.errorMessage;
      final previousError = previous?.errorMessage;
      if (error != null && error != previousError) {
        messenger.clearSnackBars();
        messenger.showSnackBar(SnackBar(content: Text(error)));
        notifier.clearError();
      }

      final succeeded = next.saveSucceeded == true;
      final alreadySucceeded = previous?.saveSucceeded == true;
      if (succeeded && !alreadySucceeded) {
        messenger.clearSnackBars();
        messenger.showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 2),
            content: Text('閾値を保存しました'),
          ),
        );
        notifier.clearSaveResult();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('ルーチン設定'),
        actions: [
          IconButton(
            tooltip: '再読み込み',
            icon: const Icon(Icons.refresh),
            onPressed: () => notifier.refresh(),
          ),
        ],
      ),
      body: SafeArea(
        child: _buildBody(
          context,
          state,
          notifier,
          formKey,
          allowableController,
          criticalController,
        ),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    RoutineSettingsState state,
    RoutineSettingsNotifier notifier,
    GlobalKey<FormState> formKey,
    TextEditingController allowableController,
    TextEditingController criticalController,
  ) {
    final isInitialLoading =
        state.isLoading && state.setting == null && state.isRoutineLoading;

    if (isInitialLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: notifier.refresh,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          _buildRoutineSection(context, state, notifier),
          const SizedBox(height: 32),
          Form(
            key: formKey,
            child: _buildThresholdSection(
              context,
              state,
              notifier,
              formKey,
              allowableController,
              criticalController,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoutineSection(
    BuildContext context,
    RoutineSettingsState state,
    RoutineSettingsNotifier notifier,
  ) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeader(
          title: 'ルーチン一覧',
          description: 'ルーチンの追加・編集・削除を行います。',
        ),
        const SizedBox(height: 16),
        if (state.isReordering)
          const Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: LinearProgressIndicator(minHeight: 4),
          ),
        if (state.isRoutineLoading && state.routines.isEmpty)
          const Center(child: CircularProgressIndicator())
        else if (state.routines.isEmpty)
          Text(
            '登録済みのルーチンがありません。下のボタンから追加してください。',
            style: theme.textTheme.bodyMedium,
          )
        else
          Column(
            children: [
              for (final entry in state.routines.asMap().entries) ...[
                RoutineCard(
                  routine: entry.value,
                  onEdit: () => _openRoutineEditor(
                    context,
                    notifier,
                    thresholds: state.setting,
                    existing: entry.value,
                  ),
                  onDelete: () =>
                      _confirmDelete(context, notifier, entry.value),
                  onMoveUp: state.isReordering || entry.key == 0
                      ? null
                      : () => notifier.moveRoutineByDelta(entry.value.id, -1),
                  onMoveDown:
                      state.isReordering ||
                          entry.key == state.routines.length - 1
                      ? null
                      : () => notifier.moveRoutineByDelta(entry.value.id, 1),
                  showLastResult: false,
                  showStatusIndicator: false,
                ),
                const SizedBox(height: 12),
              ],
            ],
          ),
        const SizedBox(height: 16),
        FilledButton.icon(
          onPressed: () =>
              _openRoutineEditor(context, notifier, thresholds: state.setting),
          icon: const Icon(Icons.add),
          label: const Text('ルーチンを追加'),
        ),
      ],
    );
  }

  Widget _buildThresholdSection(
    BuildContext context,
    RoutineSettingsState state,
    RoutineSettingsNotifier notifier,
    GlobalKey<FormState> formKey,
    TextEditingController allowableController,
    TextEditingController criticalController,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeader(
          title: '遅延許容時間',
          description: '目標時刻からどの程度の遅れを許容するかを設定します。',
        ),
        TextFormField(
          controller: allowableController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'オンタイム判定（分）',
            helperText: 'この時間以内なら「オンタイム」と判定します。',
          ),
          validator: (value) => _validateMinutes(value),
        ),
        const SizedBox(height: 24),
        const _SectionHeader(
          title: '警告判定ライン',
          description: 'この設定を超えると遅延として強調表示します。',
        ),
        TextFormField(
          controller: criticalController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: '警告判定（分）',
            helperText: 'オンタイム閾値以上の値で指定してください。',
          ),
          validator: (value) => _validateMinutes(value),
        ),
        const SizedBox(height: 32),
        FilledButton.icon(
          onPressed: state.isSaving
              ? null
              : () {
                  final formState = formKey.currentState;
                  if (formState != null && !formState.validate()) {
                    return;
                  }
                  _onSave(
                    context,
                    notifier,
                    allowableController.text,
                    criticalController.text,
                  );
                },
          icon: state.isSaving
              ? const SizedBox.square(
                  dimension: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.save),
          label: Text(state.isSaving ? '保存中...' : '保存する'),
        ),
        const SizedBox(height: 12),
        if (state.setting != null)
          TextButton.icon(
            onPressed: state.isSaving
                ? null
                : () {
                    allowableController.text = state
                        .setting!
                        .allowableDelayMinutes
                        .toString();
                    criticalController.text = state
                        .setting!
                        .criticalDelayMinutes
                        .toString();
                  },
            icon: const Icon(Icons.refresh),
            label: const Text('現在値を再読み込み'),
          ),
      ],
    );
  }

  Future<void> _onSave(
    BuildContext context,
    RoutineSettingsNotifier notifier,
    String allowable,
    String critical,
  ) async {
    final parsedAllowable = int.tryParse(allowable.trim());
    final parsedCritical = int.tryParse(critical.trim());

    if (parsedAllowable == null || parsedCritical == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('数値を入力してください。')));
      return;
    }

    final setting = RoutineThresholdSetting(
      allowableDelayMinutes: parsedAllowable,
      criticalDelayMinutes: parsedCritical,
    );

    if (!setting.isValid) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('警告判定はオンタイム判定以上に設定してください。')));
      return;
    }

    await notifier.save(setting);
  }

  Future<void> _openRoutineEditor(
    BuildContext context,
    RoutineSettingsNotifier notifier, {
    RoutineThresholdSetting? thresholds,
    RoutineEntity? existing,
  }) async {
    final defaults = thresholds ?? const RoutineThresholdSetting();
    final routine = await showRoutineEditorSheet(
      context: context,
      defaultThresholds: defaults,
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
      _showSnackBar(
        context,
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text(
            existing == null
                ? '${routine.name}を追加しました'
                : '${routine.name}を更新しました',
          ),
        ),
      );
    }
  }

  Future<void> _confirmDelete(
    BuildContext context,
    RoutineSettingsNotifier notifier,
    RoutineEntity routine,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('ルーチンを削除しますか？'),
        content: Text('${routine.name}を削除すると復元できません。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('キャンセル'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('削除'),
          ),
        ],
      ),
    );

    if (confirmed != true) {
      return;
    }

    final success = await notifier.deleteRoutine(routine.id);
    if (!context.mounted) {
      return;
    }

    if (success) {
      _showSnackBar(
        context,
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text('${routine.name}を削除しました'),
        ),
      );
    }
  }

  void _showSnackBar(BuildContext context, SnackBar snackBar) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.clearSnackBars();
    messenger.showSnackBar(snackBar);
  }
}

String? _validateMinutes(String? value) {
  if (value == null || value.trim().isEmpty) {
    return '数値を入力してください';
  }
  final parsed = int.tryParse(value.trim());
  if (parsed == null || parsed < 0) {
    return '0以上の整数を入力してください';
  }
  return null;
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        Text(
          description,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
