// Application層: 一覧画面用 Notifier（Riverpodコード生成）
// 責務: VoiceMemo の一覧取得/リフレッシュと状態管理

import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../1_states/voice_memo_list_state.dart';
import '../2_providers/voice_memo_repository_provider.dart';
import '../../1_domain/3_usecases/list_voice_memos.dart';

part 'voice_memo_list_notifier.g.dart';

@riverpod
class VoiceMemoListNotifier extends _$VoiceMemoListNotifier {
  // 初期ビルド時に一覧を取得
  @override
  FutureOr<VoiceMemoListState> build() async {
    // 初期状態はローディング
    state = const AsyncLoading();

    final repo = ref.watch(voiceMemoRepositoryProvider);
    final usecase = ListVoiceMemos(repo);

    try {
      final items = await usecase(includeTrashed: false);
      return VoiceMemoListState(items: items, isLoading: false);
    } catch (e) {
      // 失敗時はエラー状態を返却
      return VoiceMemoListState(
        items: const [],
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  // 明示的な再取得
  Future<void> refresh({bool includeTrashed = false}) async {
    state = const AsyncLoading();

    final repo = ref.read(voiceMemoRepositoryProvider);
    final usecase = ListVoiceMemos(repo);

    state = await AsyncValue.guard(() async {
      final items = await usecase(includeTrashed: includeTrashed);
      return VoiceMemoListState(items: items, isLoading: false);
    });
  }
}