import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutter_init_3/features/user/routine_status/1_domain/1_entities/routine_entity.dart';

import 'routine_settings_repository_provider.dart';

part 'routine_threshold_provider.g.dart';

@riverpod
Stream<RoutineThresholdSetting> routineThresholdStream(Ref ref) {
  final repository = ref.watch(routineSettingsRepositoryProvider);
  return repository.watch();
}

@riverpod
Future<RoutineThresholdSetting> routineThreshold(Ref ref) async {
  final repository = ref.watch(routineSettingsRepositoryProvider);
  return repository.fetch();
}
