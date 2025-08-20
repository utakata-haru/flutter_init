// DB初期化・接続状態を表すState
// freezedは後続で導入するが、まずは単純なsealedクラスで表現

sealed class DatabaseState {
  const DatabaseState();
}

class DatabaseInitial extends DatabaseState {
  const DatabaseInitial();
}

class DatabaseLoading extends DatabaseState {
  const DatabaseLoading();
}

class DatabaseReady extends DatabaseState {
  const DatabaseReady();
}

class DatabaseError extends DatabaseState {
  final Object error;
  final StackTrace? stackTrace;
  const DatabaseError(this.error, [this.stackTrace]);
}