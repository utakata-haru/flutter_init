// デザインシステムのトークン定義エンティティ
// カラーパレット、サイズ、アニメーション定数等の中核的な値

import 'package:flutter/material.dart';

/// デザイントークンエンティティ - 不変なデザイン定数
class DesignTokens {
  const DesignTokens._();

  // カラートークン - 紫とピンクのグラデーション基調
  static const colorPrimary = Color(0xFF6366F1); // インディゴ
  static const colorSecondary = Color(0xFFEC4899); // ピンク
  static const colorAccent = Color(0xFF8B5CF6); // バイオレット
  
  // グラデーション定義
  static const primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [colorPrimary, colorSecondary],
  );
  
  static const surfaceGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF1F2937), // ダークグレー
      Color(0xFF374151), // ミディアムグレー
    ],
  );

  // ガラスモーフィズム用の色
  static const glassBackground = Color(0x1AFFFFFF); // 半透明白
  static const glassBorder = Color(0x33FFFFFF); // 薄い白ボーダー

  // サイズトークン
  static const spacingXs = 4.0;
  static const spacingS = 8.0;
  static const spacingM = 16.0;
  static const spacingL = 24.0;
  static const spacingXl = 32.0;
  static const spacingXxl = 48.0;

  // ボーダー半径
  static const radiusS = 8.0;
  static const radiusM = 12.0;
  static const radiusL = 16.0;
  static const radiusXl = 24.0;
  static const radiusCircle = 999.0;

  // アニメーション定数
  static const animationDurationFast = Duration(milliseconds: 200);
  static const animationDurationMedium = Duration(milliseconds: 300);
  static const animationDurationSlow = Duration(milliseconds: 500);

  // エレベーション（影）
  static const elevationLow = 2.0;
  static const elevationMedium = 4.0;
  static const elevationHigh = 8.0;

  // ブラー効果
  static const blurLight = 10.0;
  static const blurMedium = 20.0;
  static const blurHeavy = 30.0;
}