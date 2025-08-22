// Application層: 詳細画面用 Notifier
// 責務: VoiceMemo の詳細取得/再取得

import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../1_states/voice_memo_detail_state.dart';
import '../2_providers/voice_memo_repository_provider.dart';
import '../../1_domain/3_usecases/get_voice_memo_detail.dart';

part 'voice_memo_detail_notifier.g.dart';

@riverpod
class VoiceMemoDetailNotifier extends _$VoiceMemoDetailNotifier {
  // 初回は item がないため、空の状態から開始
  @override
  FutureOr<VoiceMemoDetailState> build() async {
    // 初期はローディング false で空
    return VoiceMemoDetailState.initial().copyWith(isLoading: false);
  }

  // 指定IDのメモを取得
  Future<void> fetch(String id) async {
    state = const AsyncLoading();
    final repo = ref.read(voiceMemoRepositoryProvider);
    final usecase = GetVoiceMemoDetail(repo);

    state = await AsyncValue.guard(() async {
      final item = await usecase(id);
      return VoiceMemoDetailState(
        item: item,
        isLoading: false,
      );
    });
  }
}