// ポモドーロタイマーのUI（Organism）
// Notifierの状態を購読し、操作ボタンとプログレス表示を行う

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../1_domain/1_entities/pomodoro_session.dart';
import '../../../2_application/3_notifiers/pomodoro_notifier.dart';

class PomodoroTimerWidget extends ConsumerWidget {
  const PomodoroTimerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 現在の状態を購読
    final state = ref.watch(pomodoroNotifierProvider);
    // 操作用のNotifier参照
    final notifier = ref.read(pomodoroNotifierProvider.notifier);

    final session = state.currentSession;

    final phaseText = () {
      if (session == null) return 'Idle';
      switch (session.phase) {
        case PomodoroPhase.focus:
          return '集中 (Focus)';
        case PomodoroPhase.shortBreak:
          return '短休憩 (Short Break)';
        case PomodoroPhase.longBreak:
          return '長休憩 (Long Break)';
      }
    }();

    String formatSeconds(int secs) {
      final m = (secs ~/ 60).toString().padLeft(2, '0');
      final s = (secs % 60).toString().padLeft(2, '0');
      return '$m:$s';
    }

    final remaining = session?.remainingSeconds ?? state.config.focusSeconds;

    // フェーズごとにリングの色を変える
    final colorScheme = Theme.of(context).colorScheme;
    final ringColor = () {
      switch (session?.phase) {
        case PomodoroPhase.focus:
          return colorScheme.primary;
        case PomodoroPhase.shortBreak:
          return colorScheme.secondary;
        case PomodoroPhase.longBreak:
          return colorScheme.tertiary;
        default:
          return colorScheme.primary;
      }
    }();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // フェーズ表示
        Text('フェーズ: $phaseText', style: const TextStyle(fontSize: 20)),
        const SizedBox(height: 16),

        // 円形の進捗リング + 中央に残り時間
        SizedBox(
          width: 260,
          height: 260,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // 背景トラック（薄い色）
              SizedBox(
                width: 240,
                height: 240,
                child: CircularProgressIndicator(
                  value: 1,
                  strokeWidth: 14,
                  backgroundColor: colorScheme.surfaceVariant,
                  valueColor: AlwaysStoppedAnimation<Color>(colorScheme.surfaceVariant),
                ),
              ),
              // 実際の進捗リング（満タン→ゼロへ減少するよう反転）
              SizedBox(
                width: 240,
                height: 240,
                child: CircularProgressIndicator(
                  // ここで進捗を反転: 1.0 - progress
                  value: (1.0 - state.progress).clamp(0.0, 1.0),
                  strokeWidth: 14,
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(ringColor),
                ),
              ),
              // 中央の残り時間テキスト
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    formatSeconds(remaining),
                    style: const TextStyle(
                      fontSize: 44,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '残り時間',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),
        // 操作ボタン群
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 12,
          runSpacing: 12,
          children: [
            ElevatedButton.icon(
              onPressed: state.isStarting || state.isRunning ? null : () => notifier.startPomodoro(),
              icon: const Icon(Icons.play_arrow),
              label: const Text('開始'),
            ),
            ElevatedButton.icon(
              onPressed: session != null && session.status == SessionStatus.ongoing ? () => notifier.pausePomodoro() : null,
              icon: const Icon(Icons.pause),
              label: const Text('一時停止'),
            ),
            ElevatedButton.icon(
              onPressed: session != null && session.status == SessionStatus.paused ? () => notifier.resumePomodoro() : null,
              icon: const Icon(Icons.play_circle),
              label: const Text('再開'),
            ),
            OutlinedButton.icon(
              onPressed: session != null ? () => notifier.resetPomodoro() : null,
              icon: const Icon(Icons.stop),
              label: const Text('リセット'),
            ),
          ],
        ),
        if (state.errorMessage != null) ...[
          const SizedBox(height: 12),
          Text(
            state.errorMessage!,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ],
      ],
    );
  }
}