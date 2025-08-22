// Application層: 検索画面用の状態クラス
// 役割: 検索条件と結果の一覧、読み込み/エラー状態を保持します。

import '../../1_domain/1_entities/voice_memo_entity.dart';
import '../../1_domain/1_entities/tag_entity.dart';

class VoiceMemoSearchState {
  final String? query;
  final List<Tag>? tags;
  final DateTime? from;
  final DateTime? to;
  final bool? starredOnly;

  final List<VoiceMemo> results;
  final bool isLoading;
  final String? errorMessage;

  const VoiceMemoSearchState({
    this.query,
    this.tags,
    this.from,
    this.to,
    this.starredOnly,
    required this.results,
    required this.isLoading,
    this.errorMessage,
  });

  factory VoiceMemoSearchState.initial() => const VoiceMemoSearchState(
        results: <VoiceMemo>[],
        isLoading: false,
      );

  VoiceMemoSearchState copyWith({
    String? query,
    List<Tag>? tags,
    DateTime? from,
    DateTime? to,
    bool? starredOnly,
    List<VoiceMemo>? results,
    bool? isLoading,
    String? errorMessage,
  }) {
    return VoiceMemoSearchState(
      query: query ?? this.query,
      tags: tags ?? this.tags,
      from: from ?? this.from,
      to: to ?? this.to,
      starredOnly: starredOnly ?? this.starredOnly,
      results: results ?? this.results,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}