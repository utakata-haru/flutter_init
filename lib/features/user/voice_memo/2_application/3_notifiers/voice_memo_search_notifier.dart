// Application層: 検索用 Notifier
// 責務: 検索条件の保持と検索実行

import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../1_states/voice_memo_search_state.dart';
import '../2_providers/voice_memo_repository_provider.dart';
import '../../1_domain/1_entities/tag_entity.dart';
import '../../1_domain/3_usecases/search_voice_memos.dart';

part 'voice_memo_search_notifier.g.dart';

@riverpod
class VoiceMemoSearchNotifier extends _$VoiceMemoSearchNotifier {
  @override
  FutureOr<VoiceMemoSearchState> build() async {
    // 初期状態
    return VoiceMemoSearchState.initial();
  }

  // 条件を更新して検索実行
  Future<void> search({
    String? query,
    List<Tag>? tags,
    DateTime? from,
    DateTime? to,
    bool? starredOnly,
  }) async {
    state = const AsyncLoading();

    final repo = ref.read(voiceMemoRepositoryProvider);
    final usecase = SearchVoiceMemos(repo);

    state = await AsyncValue.guard(() async {
      final results = await usecase(
        query: query,
        tags: tags,
        from: from,
        to: to,
        starredOnly: starredOnly,
      );
      return VoiceMemoSearchState(
        query: query,
        tags: tags,
        from: from,
        to: to,
        starredOnly: starredOnly,
        results: results,
        isLoading: false,
      );
    });
  }
}