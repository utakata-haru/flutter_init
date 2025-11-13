import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:uuid/uuid.dart';

import 'package:flutter_init_3/features/user/routine_status/1_domain/1_entities/routine_entity.dart';

Future<RoutineEntity?> showRoutineEditorSheet({
  required BuildContext context,
  required RoutineThresholdSetting defaultThresholds,
  TimeOfDay? initialTime,
  RoutineEntity? existing,
}) {
  final time =
      initialTime ??
      (existing != null
          ? TimeOfDay(
              hour: existing.targetTime.hour,
              minute: existing.targetTime.minute,
            )
          : TimeOfDay.now());

  return showModalBottomSheet<RoutineEntity>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    builder: (modalContext) {
      final viewInsets = MediaQuery.of(modalContext).viewInsets.bottom;
      return Padding(
        padding: EdgeInsets.only(bottom: viewInsets),
        child: RoutineEditorSheet(
          defaultThresholds: defaultThresholds,
          initialTime: time,
          existing: existing,
        ),
      );
    },
  );
}

class RoutineEditorSheet extends HookWidget {
  const RoutineEditorSheet({
    super.key,
    required this.defaultThresholds,
    required this.initialTime,
    this.existing,
  });

  final RoutineThresholdSetting defaultThresholds;
  final TimeOfDay initialTime;
  final RoutineEntity? existing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final navigator = Navigator.of(context);
    final nameController = useTextEditingController(text: existing?.name ?? '');
    final nameValue = useValueListenable(nameController);
    final selectedTime = useState(initialTime);
    final uuid = useMemoized(Uuid.new);

    Future<void> pickTime() async {
      final picked = await showTimePicker(
        context: context,
        initialTime: selectedTime.value,
        builder: (context, child) => child ?? const SizedBox.shrink(),
      );
      if (picked != null) {
        selectedTime.value = picked;
      }
    }

    void submit() {
      final trimmedName = nameValue.text.trim();
      if (trimmedName.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('ルーチン名を入力してください。')));
        return;
      }

      final entity = RoutineEntity(
        id: existing?.id ?? uuid.v4(),
        name: trimmedName,
        targetTime: RoutineTime(
          hour: selectedTime.value.hour,
          minute: selectedTime.value.minute,
        ),
        thresholds: existing?.thresholds ?? defaultThresholds,
        lastResult: existing?.lastResult,
      );

      navigator.pop(entity);
    }

    final displayTime = selectedTime.value.format(context);
    final isSaveEnabled = nameValue.text.trim().isNotEmpty;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  existing == null ? 'ルーチンを追加' : 'ルーチンを編集',
                  style: theme.textTheme.titleLarge,
                ),
                IconButton(
                  tooltip: '閉じる',
                  onPressed: navigator.pop,
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'ルーチン名',
                hintText: '例: 起床、出勤準備',
              ),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('目標時刻'),
              subtitle: Text(displayTime),
              trailing: const Icon(Icons.schedule),
              onTap: pickTime,
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: isSaveEnabled ? submit : null,
              icon: const Icon(Icons.save),
              label: Text(existing == null ? '保存' : '更新する'),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
