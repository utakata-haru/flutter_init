import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../1_states/note_state.dart';
import '../2_providers/note_providers.dart';
import '../../1_domain/1_entities/note_entity.dart';

part 'note_list_notifier.g.dart';

/// メモ一覧の状態管理を行うNotifier
/// 
/// メモの一覧取得、検索、リフレッシュなどの操作を管理し、
/// 対応する状態変更をUIに提供します。
@riverpod
class NoteListNotifier extends _$NoteListNotifier {
  /// 初期状態を返す
  @override
  NoteListState build() => const NoteListState.initial();

  /// メモ一覧を取得する
  Future<void> loadNotes({
    int? limit,
    int? offset,
    bool isRefresh = false,
  }) async {
    // リフレッシュ以外の場合、既にロード済みならスキップ
    final currentState = state;
    if (!isRefresh && currentState is NoteListStateLoaded) {
      return;
    }

    // ローディング状態に変更
    state = const NoteListState.loading();

    try {
      final getNotesUseCase = await ref.read(getNotesUseCaseProvider.future);
      final notes = await getNotesUseCase.call(
        limit: limit,
        offset: offset,
      );

      // 成功状態に変更
      state = NoteListState.loaded(notes);
    } catch (e, stackTrace) {
      // エラー状態に変更
      _handleError(e, stackTrace, 'メモ一覧の取得に失敗しました');
    }
  }

  /// メモ一覧をリフレッシュする
  Future<void> refreshNotes() async {
    await loadNotes(isRefresh: true);
  }

  /// メモを削除する（一覧から削除）
  Future<void> deleteNote(String noteId) async {
    try {
      final deleteNoteUseCase = await ref.read(deleteNoteUseCaseProvider.future);
      await deleteNoteUseCase.call(noteId);

      // 現在の状態が loaded の場合、そのメモを一覧から削除
      state.maybeWhen(
        loaded: (notes) {
          final updatedNotes = notes.where((note) => note.id != noteId).toList();
          state = NoteListState.loaded(updatedNotes);
        },
        orElse: () {
          // 削除後に一覧を再読み込み
          refreshNotes();
        },
      );
    } catch (e, stackTrace) {
      _handleError(e, stackTrace, 'メモの削除に失敗しました');
    }
  }

  /// 新しいメモが作成された際の状態更新
  void onNoteCreated(NoteEntity newNote) {
    state.maybeWhen(
      loaded: (notes) {
        // 新しいメモを先頭に追加
        final updatedNotes = <NoteEntity>[newNote, ...notes];
        state = NoteListState.loaded(updatedNotes);
      },
      orElse: () {
        // 現在の状態がloadedでない場合は、一覧を再読み込み
        refreshNotes();
      },
    );
  }

  /// メモが更新された際の状態更新
  void onNoteUpdated(NoteEntity updatedNote) {
    state.maybeWhen(
      loaded: (notes) {
        final updatedNotes = notes.map((note) {
          return note.id == updatedNote.id ? updatedNote : note;
        }).toList();
        
        // 更新日時でソートし直し
        updatedNotes.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
        
        state = NoteListState.loaded(updatedNotes);
      },
      orElse: () {
        // 現在の状態がloadedでない場合は、一覧を再読み込み
        refreshNotes();
      },
    );
  }

  /// 状態を初期化する
  void reset() {
    state = const NoteListState.initial();
  }

  /// エラーハンドリングのヘルパーメソッド
  void _handleError(dynamic error, StackTrace stackTrace, String defaultMessage) {
    // エラーログの出力（実際のアプリではロギングライブラリを使用）
    // 開発時のみログ出力（本番環境では適切なロギングライブラリを使用）
    // ignore: avoid_print
    print('NoteListNotifier Error: $error');
    // ignore: avoid_print
    print('StackTrace: $stackTrace');

    // エラーメッセージの決定
    String errorMessage = defaultMessage;
    if (error is Exception) {
      final errorString = error.toString();
      if (errorString.contains('ValidationException') ||
          errorString.contains('ArgumentError') ||
          errorString.contains('RepositoryException')) {
        // ユーザーフレンドリーなエラーメッセージを抽出
        final match = RegExp(r': (.+)$').firstMatch(errorString);
        if (match != null) {
          errorMessage = match.group(1) ?? defaultMessage;
        }
      }
    }

    state = NoteListState.error(errorMessage);
  }
}
