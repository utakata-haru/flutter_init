import 'package:freezed_annotation/freezed_annotation.dart';
import '../../1_domain/1_entities/note_entity.dart';

part 'note_state.freezed.dart';

/// メモ一覧の状態を管理するステートクラス
@freezed
class NoteListState with _$NoteListState {
  /// 初期状態
  const factory NoteListState.initial() = NoteListStateInitial;
  
  /// ローディング状態
  const factory NoteListState.loading() = NoteListStateLoading;
  
  /// データ読み込み完了状態
  const factory NoteListState.loaded(List<NoteEntity> notes) = NoteListStateLoaded;
  
  /// エラー状態
  const factory NoteListState.error(String message) = NoteListStateError;
}

/// メモ検索の状態を管理するステートクラス
@freezed
class NoteSearchState with _$NoteSearchState {
  /// 初期状態（検索未実行）
  const factory NoteSearchState.initial() = NoteSearchStateInitial;
  
  /// 検索中状態
  const factory NoteSearchState.searching() = NoteSearchStateSearching;
  
  /// 検索結果読み込み完了状態
  const factory NoteSearchState.loaded({
    required String query,
    required List<NoteEntity> results,
    required int totalCount,
  }) = NoteSearchStateLoaded;
  
  /// 検索結果が空の状態
  const factory NoteSearchState.empty(String query) = NoteSearchStateEmpty;
  
  /// 検索エラー状態
  const factory NoteSearchState.error(String message) = NoteSearchStateError;
}

/// メモフォーム（作成・編集）の状態を管理するステートクラス
@freezed
class NoteFormState with _$NoteFormState {
  /// 初期状態
  const factory NoteFormState.initial() = NoteFormStateInitial;
  
  /// 編集中状態
  const factory NoteFormState.editing({
    required String title,
    required String content,
    required bool isValid,
    List<String>? validationErrors,
    NoteEntity? originalNote, // 編集時の元メモ
  }) = NoteFormStateEditing;
  
  /// 保存中状態
  const factory NoteFormState.saving() = NoteFormStateSaving;
  
  /// 保存完了状態
  const factory NoteFormState.saved(NoteEntity note) = NoteFormStateSaved;
  
  /// 削除中状態
  const factory NoteFormState.deleting() = NoteFormStateDeleting;
  
  /// 削除完了状態
  const factory NoteFormState.deleted() = NoteFormStateDeleted;
  
  /// エラー状態
  const factory NoteFormState.error(String message) = NoteFormStateError;
}

/// メモの詳細状態を管理するステートクラス
@freezed
class NoteDetailState with _$NoteDetailState {
  /// 初期状態
  const factory NoteDetailState.initial() = NoteDetailStateInitial;
  
  /// ローディング状態
  const factory NoteDetailState.loading() = NoteDetailStateLoading;
  
  /// データ読み込み完了状態
  const factory NoteDetailState.loaded(NoteEntity note) = NoteDetailStateLoaded;
  
  /// メモが見つからない状態
  const factory NoteDetailState.notFound() = NoteDetailStateNotFound;
  
  /// エラー状態
  const factory NoteDetailState.error(String message) = NoteDetailStateError;
}

/// アプリケーション全体のメモ関連統計情報状態
@freezed
class NoteStatsState with _$NoteStatsState {
  /// 初期状態
  const factory NoteStatsState.initial() = NoteStatsStateInitial;
  
  /// ローディング状態
  const factory NoteStatsState.loading() = NoteStatsStateLoading;
  
  /// データ読み込み完了状態
  const factory NoteStatsState.loaded({
    required int totalNotes,
    required int todayNotes,
    required int weekNotes,
    required List<NoteEntity> recentNotes,
    required Map<String, dynamic> storageInfo,
  }) = NoteStatsStateLoaded;
  
  /// エラー状態
  const factory NoteStatsState.error(String message) = NoteStatsStateError;
}

/// 非同期操作の汎用状態クラス
@freezed
class AsyncOperationState<T> with _$AsyncOperationState<T> {
  /// 初期状態
  const factory AsyncOperationState.initial() = AsyncOperationStateInitial<T>;
  
  /// 処理中状態
  const factory AsyncOperationState.loading() = AsyncOperationStateLoading<T>;
  
  /// 成功状態
  const factory AsyncOperationState.success(T data) = AsyncOperationStateSuccess<T>;
  
  /// エラー状態
  const factory AsyncOperationState.error(String message) = AsyncOperationStateError<T>;
}

// State拡張メソッド
extension NoteListStateExtension on NoteListState {
  /// ロード済み状態かどうか
  bool get isLoaded => this is NoteListStateLoaded;
  
  /// ローディング中かどうか
  bool get isLoading => this is NoteListStateLoading;
  
  /// エラー状態かどうか
  bool get hasError => this is NoteListStateError;
  
  /// メモリストを取得（ロード済みの場合のみ）
  List<NoteEntity> get notesOrEmpty {
    return maybeWhen(
      loaded: (notes) => notes,
      orElse: () => [],
    );
  }
  
  /// エラーメッセージを取得
  String? get errorMessage {
    return maybeWhen(
      error: (message) => message,
      orElse: () => null,
    );
  }
}

extension NoteSearchStateExtension on NoteSearchState {
  /// 検索結果があるかどうか
  bool get hasResults => maybeWhen(
    loaded: (query, results, totalCount) => results.isNotEmpty,
    orElse: () => false,
  );
  
  /// 検索中かどうか
  bool get isSearching => this is NoteSearchStateSearching;
  
  /// 検索結果を取得
  List<NoteEntity> get resultsOrEmpty {
    return maybeWhen(
      loaded: (query, results, totalCount) => results,
      orElse: () => [],
    );
  }
  
  /// 現在の検索クエリを取得
  String? get currentQuery {
    return maybeWhen(
      loaded: (query, results, totalCount) => query,
      empty: (query) => query,
      orElse: () => null,
    );
  }
}

extension NoteFormStateExtension on NoteFormState {
  /// 編集中かどうか
  bool get isEditing => this is NoteFormStateEditing;
  
  /// 保存中かどうか
  bool get isSaving => this is NoteFormStateSaving;
  
  /// 削除中かどうか
  bool get isDeleting => this is NoteFormStateDeleting;
  
  /// フォームが有効かどうか
  bool get isFormValid => maybeWhen(
    editing: (title, content, isValid, validationErrors, originalNote) => isValid,
    orElse: () => false,
  );
  
  /// 現在のタイトルを取得
  String get currentTitle => maybeWhen(
    editing: (title, content, isValid, validationErrors, originalNote) => title,
    orElse: () => '',
  );
  
  /// 現在の本文を取得
  String get currentContent => maybeWhen(
    editing: (title, content, isValid, validationErrors, originalNote) => content,
    orElse: () => '',
  );
  
  /// バリデーションエラーを取得
  List<String> get validationErrors => maybeWhen(
    editing: (title, content, isValid, validationErrors, originalNote) => validationErrors ?? [],
    orElse: () => [],
  );
  
  /// 編集モードかどうか（新規作成 vs 既存編集）
  bool get isEditMode => maybeWhen(
    editing: (title, content, isValid, validationErrors, originalNote) => originalNote != null,
    orElse: () => false,
  );
}

extension AsyncOperationStateExtension<T> on AsyncOperationState<T> {
  /// 成功状態かどうか
  bool get isSuccess => this is AsyncOperationStateSuccess<T>;
  
  /// 処理中かどうか
  bool get isLoading => this is AsyncOperationStateLoading<T>;
  
  /// エラー状態かどうか
  bool get hasError => this is AsyncOperationStateError<T>;
  
  /// データを取得（成功時のみ）
  T? get dataOrNull => maybeWhen(
    success: (data) => data,
    orElse: () => null,
  );
}
