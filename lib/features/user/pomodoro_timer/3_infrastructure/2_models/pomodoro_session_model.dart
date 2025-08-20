// PomodoroSessionのデータモデル（Domain Entity ↔ データストレージ間の変換）
// Infrastracture層でのデータ永続化や外部API通信時に使用

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../1_domain/1_entities/pomodoro_session.dart';

part 'pomodoro_session_model.freezed.dart';
part 'pomodoro_session_model.g.dart';

@freezed
class PomodoroSessionModel with _$PomodoroSessionModel {
  const factory PomodoroSessionModel({
    required String id,
    required String phase, // enum を文字列として保存
    required int remainingSeconds,
    required int elapsedSeconds,
    required String status, // enum を文字列として保存
    required int completedFocusCount,
    required DateTime startedAt,
  }) = _PomodoroSessionModel;

  factory PomodoroSessionModel.fromJson(Map<String, dynamic> json) =>
      _$PomodoroSessionModelFromJson(json);
}

// Domain Entity → Data Model への変換拡張
extension PomodoroSessionModelExtension on PomodoroSessionModel {
  // Data Model → Domain Entity への変換
  PomodoroSession toDomainEntity() {
    return PomodoroSession(
      id: id,
      phase: _stringToPhase(phase),
      remainingSeconds: remainingSeconds,
      elapsedSeconds: elapsedSeconds,
      status: _stringToStatus(status),
      completedFocusCount: completedFocusCount,
      startedAt: startedAt,
    );
  }

  // 文字列からPomodoroPhaseに変換
  PomodoroPhase _stringToPhase(String phaseString) {
    switch (phaseString) {
      case 'focus':
        return PomodoroPhase.focus;
      case 'shortBreak':
        return PomodoroPhase.shortBreak;
      case 'longBreak':
        return PomodoroPhase.longBreak;
      default:
        throw ArgumentError('Unknown phase: $phaseString');
    }
  }

  // 文字列からSessionStatusに変換
  SessionStatus _stringToStatus(String statusString) {
    switch (statusString) {
      case 'ongoing':
        return SessionStatus.ongoing;
      case 'paused':
        return SessionStatus.paused;
      case 'completed':
        return SessionStatus.completed;
      case 'cancelled':
        return SessionStatus.cancelled;
      default:
        throw ArgumentError('Unknown status: $statusString');
    }
  }
}

// Domain Entity → Data Model への変換拡張
extension PomodoroSessionToDomainExtension on PomodoroSession {
  // Domain Entity → Data Model への変換
  PomodoroSessionModel toDataModel() {
    return PomodoroSessionModel(
      id: id,
      phase: _phaseToString(phase),
      remainingSeconds: remainingSeconds,
      elapsedSeconds: elapsedSeconds,
      status: _statusToString(status),
      completedFocusCount: completedFocusCount,
      startedAt: startedAt,
    );
  }

  // PomodoroPhaseから文字列に変換
  String _phaseToString(PomodoroPhase phase) {
    switch (phase) {
      case PomodoroPhase.focus:
        return 'focus';
      case PomodoroPhase.shortBreak:
        return 'shortBreak';
      case PomodoroPhase.longBreak:
        return 'longBreak';
    }
  }

  // SessionStatusから文字列に変換
  String _statusToString(SessionStatus status) {
    switch (status) {
      case SessionStatus.ongoing:
        return 'ongoing';
      case SessionStatus.paused:
        return 'paused';
      case SessionStatus.completed:
        return 'completed';
      case SessionStatus.cancelled:
        return 'cancelled';
    }
  }
}