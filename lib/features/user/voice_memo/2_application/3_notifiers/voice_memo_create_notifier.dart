// Application層: 作成用 Notifier
// 責務: 新規 VoiceMemo の作成

import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../1_domain/1_entities/tag_entity.dart';
import '../../1_domain/1_entities/voice_memo_entity.dart';
import '../2_providers/voice_memo_repository_provider.dart';
import '../../1_domain/3_usecases/create_voice_memo.dart';

part 'voice_memo_create_notifier.g.dart';

@riverpod
class VoiceMemoCreateNotifier extends _$VoiceMemoCreateNotifier {
  @override
  FutureOr<VoiceMemo?> build() async {
    // 初期は null（未作成）
    return null;
  }

  Future<void> create({
    required String title,
    required List<Tag> tags,
    bool isStarred = false,
    String? note,
    required int durationMs,
    required String audioPath,
    required DateTime createdAt,
  }) async {
    state = const AsyncLoading();

    final repo = ref.read(voiceMemoRepositoryProvider);
    final usecase = CreateVoiceMemo(repo);

    state = await AsyncValue.guard(() async {
      final memo = await usecase(
        title: title,
        tags: tags,
        isStarred: isStarred,
        note: note,
        durationMs: durationMs,
        audioPath: audioPath,
        createdAt: createdAt,
      );
      return memo;
    });
  }
}