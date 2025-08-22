// Application層: 詳細画面用の状態クラス
// 役割: VoiceMemo の詳細情報と読み込み状態/エラーを保持します。

import '../../1_domain/1_entities/voice_memo_entity.dart';

class VoiceMemoDetailState {
  final VoiceMemo? item;
  final bool isLoading;
  final String? errorMessage;

  const VoiceMemoDetailState({
    required this.item,
    required this.isLoading,
    this.errorMessage,
  });

  factory VoiceMemoDetailState.initial() => const VoiceMemoDetailState(
        item: null,
        isLoading: true,
      );

  VoiceMemoDetailState copyWith({
    VoiceMemo? item,
    bool? isLoading,
    String? errorMessage,
  }) {
    return VoiceMemoDetailState(
      item: item ?? this.item,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  String toString() =>
      'VoiceMemoDetailState(item: ${item?.id}, isLoading: $isLoading, error: $errorMessage)';
}