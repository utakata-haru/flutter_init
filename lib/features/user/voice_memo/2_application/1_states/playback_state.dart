// Application層: 再生状態クラス
// 役割: 再生の状態（ステータス、位置、長さ、速度、エラー、現在のファイルパス）を保持します。

enum PlaybackStatus {
  idle, // 未ロード
  loading, // ロード中
  playing, // 再生中
  paused, // 一時停止
  stopped, // 停止（先頭）
  error, // エラー
}

class PlaybackState {
  final PlaybackStatus status;
  final Duration position; // 現在位置
  final Duration duration; // 総再生時間
  final double speed; // 再生速度
  final String? currentFilePath; // 現在ロード中/再生中のファイルパス
  final String? errorMessage; // エラー内容

  const PlaybackState({
    required this.status,
    required this.position,
    required this.duration,
    required this.speed,
    this.currentFilePath,
    this.errorMessage,
  });

  factory PlaybackState.initial() => const PlaybackState(
        status: PlaybackStatus.idle,
        position: Duration.zero,
        duration: Duration.zero,
        speed: 1.0,
        currentFilePath: null,
      );

  PlaybackState copyWith({
    PlaybackStatus? status,
    Duration? position,
    Duration? duration,
    double? speed,
    String? currentFilePath,
    String? errorMessage,
  }) {
    return PlaybackState(
      status: status ?? this.status,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      speed: speed ?? this.speed,
      currentFilePath: currentFilePath ?? this.currentFilePath,
      errorMessage: errorMessage,
    );
  }

  @override
  String toString() {
    return 'PlaybackState(status: ' 
        '$status, pos: ${position.inMilliseconds}ms, dur: ${duration.inMilliseconds}ms, speed: $speed, file: $currentFilePath, err: $errorMessage)';
  }
}