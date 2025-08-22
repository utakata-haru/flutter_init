// Application層: メタ情報更新用 Notifier
// 責務: タイトル/タグ/スター/メモの更新

import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../1_domain/1_entities/tag_entity.dart';
import '../../1_domain/1_entities/voice_memo_entity.dart';
import '../2_providers/voice_memo_repository_provider.dart';
import '../../1_domain/3_usecases/update_voice_memo_meta.dart';

part 'voice_memo_update_meta_notifier.g.dart';

@riverpod
class VoiceMemoUpdateMetaNotifier extends _$VoiceMemoUpdateMetaNotifier {
  @override
  FutureOr<VoiceMemo?> build() async {
    // 初期は null（未更新）
    return null;
  }

  Future<void> updateMeta({
    required String id,
    String? title,
    List<Tag>? tags,
    bool? isStarred,
    String? note,
  }) async {
    state = const AsyncLoading();

    final repo = ref.read(voiceMemoRepositoryProvider);
    final usecase = UpdateVoiceMemoMeta(repo);

    state = await AsyncValue.guard(() async {
      final updated = await usecase(
        id: id,
        title: title,
        tags: tags,
        isStarred: isStarred,
        note: note,
      );
      return updated;
    });
  }
}