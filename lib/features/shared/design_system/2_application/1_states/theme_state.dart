// テーマ状態（アプリケーション層のState）
// Freezedを使わずにまず軽量なStateから開始（必要に応じて拡張）

import 'package:flutter/material.dart';

class ThemeState {
  // 現在のテーマ（ライト/ダークの概念を超えたカスタムテーマ）
  final ThemeData themeData;
  // 強調アニメーションの強度（0.0〜1.0）
  final double motionIntensity;

  const ThemeState({
    required this.themeData,
    required this.motionIntensity,
  });

  ThemeState copyWith({ThemeData? themeData, double? motionIntensity}) => ThemeState(
        themeData: themeData ?? this.themeData,
        motionIntensity: motionIntensity ?? this.motionIntensity,
      );
}