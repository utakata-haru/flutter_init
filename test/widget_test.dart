import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_init/app.dart';

void main() {
  testWidgets('App shows Pomodoro title', (WidgetTester tester) async {
    // ProviderScopeでAppを起動
    await tester.pumpWidget(const ProviderScope(child: App()));

    // 初期画面にAppBarタイトルが表示されることを確認
    expect(find.text('ポモドーロタイマー'), findsOneWidget);
  });
}
