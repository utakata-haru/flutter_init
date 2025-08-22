// Application層: 一覧画面用の状態クラス
// 役割: VoiceMemo の一覧と読み込み状態/エラーを保持します。

import '../../1_domain/1_entities/voice_memo_entity.dart';

class VoiceMemoListState {
  // 取得済みのボイスメモ一覧
  final List<VoiceMemo> items;
  // 読み込み中フラグ
  final bool isLoading;
  // エラーメッセージ（あれば）
  final String? errorMessage;

  const VoiceMemoListState({
    required this.items,
    required this.isLoading,
    this.errorMessage,
  });

  // 初期状態（起動直後など）
  factory VoiceMemoListState.initial() => const VoiceMemoListState(
        items: <VoiceMemo>[],
        isLoading: true,
      );

  // 部分更新用のコピー
  VoiceMemoListState copyWith({
    List<VoiceMemo>? items,
    bool? isLoading,
    String? errorMessage,
  }) {
    return VoiceMemoListState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  String toString() =>
      'VoiceMemoListState(items: ${items.length}件, isLoading: $isLoading, error: $errorMessage)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VoiceMemoListState &&
        _listEquals(other.items, items) &&
        other.isLoading == isLoading &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => _listHash(items) ^ isLoading.hashCode ^ (errorMessage?.hashCode ?? 0);
}

// リストの浅い等価比較（順序も比較）
bool _listEquals<T>(List<T> a, List<T> b) {
  if (identical(a, b)) return true;
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}

// リストの簡易ハッシュ
int _listHash<T>(List<T> list) {
  int hash = 0;
  for (final e in list) {
    hash = 0x1fffffff & (hash + e.hashCode);
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    hash ^= (hash >> 6);
  }
  hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
  hash ^= (hash >> 11);
  hash = 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  return hash;
}