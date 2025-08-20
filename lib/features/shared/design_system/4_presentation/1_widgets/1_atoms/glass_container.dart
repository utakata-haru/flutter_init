// ガラスモーフィズムのコンテナ（Atom）
// 背景のブラー、半透明、境界線を適用するベースUI

import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../1_domain/1_entities/design_tokens.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double elevation;

  const GlassContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(DesignTokens.spacingM),
    this.borderRadius = DesignTokens.radiusL,
    this.elevation = DesignTokens.elevationLow,
  });

  @override
  Widget build(BuildContext context) {
    // ThemeStateのモーション強度に応じてブラーを変える拡張は後続で
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: DesignTokens.blurLight,
          sigmaY: DesignTokens.blurLight,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: DesignTokens.glassBackground,
            border: Border.all(color: DesignTokens.glassBorder),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: elevation,
              ),
            ],
          ),
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}