// DB初期化の実処理を担う Notifier
// Provider は公開の窓口、ビジネスロジックは Notifier に集約します。

import 'package:riverpod/riverpod.dart';

import '../1_states/database_state.dart';
import '../2_providers/database_providers.dart';

class DatabaseNotifier extends StateNotifier<DatabaseState> {
  DatabaseNotifier(this._ref) : super(const DatabaseInitial());

  final Ref _ref; // Riverpodの参照

  /// アプリ起動時に呼び出される初期化処理
  Future<void> initialize() async {
    state = const DatabaseLoading();
    try {
      final usecase = _ref.read(initializeDatabaseUsecaseProvider);
      await usecase();
      state = const DatabaseReady();
    } catch (e, st) {
      state = DatabaseError(e, st);
    }
  }
}