// Application層: 文字起こし要求用 Notifier
// 責務: 指定メモの文字起こしを要求し、結果の最新状態（エンティティ）を返す

import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../1_domain/1_entities/voice_memo_entity.dart';
import '../2_providers/voice_memo_repository_provider.dart';
import '../../1_domain/3_usecases/request_transcription.dart';

part 'voice_memo_request_transcription_notifier.g.dart';

@riverpod
class VoiceMemoRequestTranscriptionNotifier extends _$VoiceMemoRequestTranscriptionNotifier {
  @override
  FutureOr<VoiceMemo?> build() async {
    return null;
  }

  Future<void> request(String id) async {
    state = const AsyncLoading();
    final repo = ref.read(voiceMemoRepositoryProvider);
    final usecase = RequestTranscription(repo);

    state = await AsyncValue.guard(() async => usecase(id: id));
  }
}