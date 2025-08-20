// TimerRepository を公開するProvider（Application層）
// Infrastructure層の実装でオーバーライドされる想定

import 'package:flutter_riverpod/flutter_riverpod.dart'; // Ref型はflutter_riverpodから取得
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../1_domain/2_repositories/timer_repository.dart';
import '../../3_infrastructure/3_repositories/timer_repository_impl.dart';

part 'timer_repository_provider.g.dart';

@riverpod
TimerRepository timerRepository(Ref ref) {
  // デフォルトではローカルのTimerRepositoryImplを使用
  // 上位（main.dartなど）のProviderScopeで必要に応じてoverride可能
  return TimerRepositoryImpl();
}