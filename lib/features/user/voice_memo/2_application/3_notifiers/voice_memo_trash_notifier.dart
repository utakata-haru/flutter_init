// Application層: ゴミ箱操作用 Notifier
// 責務: 移動/復元/完全削除のコマンド実行

import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../2_providers/voice_memo_repository_provider.dart';
import '../../1_domain/3_usecases/move_to_trash.dart';
import '../../1_domain/3_usecases/restore_from_trash.dart';
import '../../1_domain/3_usecases/hard_delete_voice_memo.dart';

part 'voice_memo_trash_notifier.g.dart';

@riverpod
class VoiceMemoTrashNotifier extends _$VoiceMemoTrashNotifier {
  @override
  FutureOr<void> build() async {
    // コマンド系なので保持状態は不要
  }

  Future<void> moveToTrash(String id) async {
    state = const AsyncLoading();
    final repo = ref.read(voiceMemoRepositoryProvider);
    final usecase = MoveToTrash(repo);
    state = await AsyncValue.guard(() async => usecase(id));
  }

  Future<void> restoreFromTrash(String id) async {
    state = const AsyncLoading();
    final repo = ref.read(voiceMemoRepositoryProvider);
    final usecase = RestoreFromTrash(repo);
    state = await AsyncValue.guard(() async => usecase(id));
  }

  Future<void> hardDelete(String id) async {
    state = const AsyncLoading();
    final repo = ref.read(voiceMemoRepositoryProvider);
    final usecase = HardDeleteVoiceMemo(repo);
    state = await AsyncValue.guard(() async => usecase(id));
  }
}