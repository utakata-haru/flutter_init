// エントリポイント専用ファイル
// ルーティングやテーマ適用は lib/app.dart に委譲します

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';

void main() {
  // アプリ全体でRiverpodの依存注入を有効化
  runApp(const ProviderScope(child: App()));
}
