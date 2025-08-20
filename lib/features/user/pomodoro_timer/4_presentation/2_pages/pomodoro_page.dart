// ポモドーロタイマーのメインページ
// 全体レイアウトとタイマーウィジェットの配置を管理

import 'package:flutter/material.dart';

import '../1_widgets/3_organisms/pomodoro_timer_widget.dart';

class PomodoroPage extends StatelessWidget {
  const PomodoroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ポモドーロタイマー'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // メインのポモドーロタイマーウィジェット
              PomodoroTimerWidget(),
            ],
          ),
        ),
      ),
    );
  }
}