import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/shared/design_system/2_application/3_notifiers/theme_notifier.dart';
// Pomodoro Notifier を利用するためのインポート
import 'features/user/pomodoro_timer/1_domain/1_entities/pomodoro_session.dart';
import 'features/user/pomodoro_timer/2_application/3_notifiers/pomodoro_notifier.dart';

void main() {
  // アプリ全体でRiverpodの依存注入を有効化
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // アプリ全体のテーマをRiverpodのThemeNotifierから適用
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeNotifierProvider);
    return MaterialApp(
      title: 'Pomodoro Timer',
      debugShowCheckedModeBanner: false,
      theme: themeState.themeData,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // RiverpodのConsumerでPomodoroの状態と操作を提供
              Consumer(
                builder: (context, ref, _) {
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

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('フェーズ: $phaseText', style: const TextStyle(fontSize: 20)),
                      const SizedBox(height: 8),
                      Text('残り時間: ${formatSeconds(remaining)}', style: const TextStyle(fontSize: 24, fontFeatures: [FontFeature.tabularFigures()])),
                      const SizedBox(height: 16),
                      // 進捗バー
                      SizedBox(
                        width: 320,
                        child: LinearProgressIndicator(value: state.progress),
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
                        Text(state.errorMessage!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
                      ],
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
