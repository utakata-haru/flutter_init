// テーマの生成と更新ロジック（Notifier）
// Riverpodアノテーションを使用して型安全なNotifierを生成

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../1_domain/1_entities/design_tokens.dart';
import '../1_states/theme_state.dart';

part 'theme_notifier.g.dart';

@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  // 初期状態の生成
  @override
  ThemeState build() {
    // 初期テーマを生成
    final theme = _buildBaseTheme();
    return ThemeState(themeData: theme, motionIntensity: 0.5);
  }

  // モーション強度を更新
  void setMotion(double value) {
    final clamped = value.clamp(0.0, 1.0);
    state = state.copyWith(motionIntensity: clamped);
  }

  // 配色をアップデート（将来的に配色のプリセット切替用）
  void updateColors({Color? primary, Color? secondary}) {
    final newTheme = state.themeData.copyWith(
      colorScheme: state.themeData.colorScheme.copyWith(
        primary: primary ?? state.themeData.colorScheme.primary,
        secondary: secondary ?? state.themeData.colorScheme.secondary,
      ),
    );
    state = state.copyWith(themeData: newTheme);
  }

  ThemeData _buildBaseTheme() {
    // 非Materialベースだが、最低限のThemeDataを利用して全体統一（独自ウィジェットで表現）
    final base = ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true, // Materialコンポーネント直接は使わないがThemeのスロットは活用
      scaffoldBackgroundColor: const Color(0xFF0B1020),
      colorScheme: const ColorScheme.dark(
        primary: DesignTokens.colorPrimary,
        secondary: DesignTokens.colorSecondary,
        surface: Color(0xFF0F172A),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 48, fontWeight: FontWeight.w700),
        displayMedium: TextStyle(fontSize: 36, fontWeight: FontWeight.w700),
        titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      ),
    );

    return base;
  }
}