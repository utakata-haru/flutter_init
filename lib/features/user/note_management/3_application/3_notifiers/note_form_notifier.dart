import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../1_states/note_state.dart';
import '../2_providers/note_providers.dart';
import '../../1_domain/1_entities/note_entity.dart';

part 'note_form_notifier.g.dart';

/// メモフォームの状態管理を行うNotifier
/// 
/// メモの作成、更新、削除などのフォーム操作を管理し、
/// 対応する状態変更をUIに提供します。
@riverpod
class NoteFormNotifier extends _$NoteFormNotifier {
  /// 初期状態を返す
  @override
  NoteFormState build() => const NoteFormState.initial();

  /// 編集状態を開始する
  void startEditing({
    String title = '',
    String content = '',
    NoteEntity? originalNote,
  }) {
    state = NoteFormState.editing(
      title: title,
      content: content,
      isValid: _validateInput(title, content),
      validationErrors: _getValidationErrors(title, content),
      originalNote: originalNote,
    );
  }

  /// フォームの値を更新する
  void updateForm({
    String? title,
    String? content,
  }) {
    state.maybeWhen(
      editing: (currentTitle, currentContent, isValid, validationErrors, originalNote) {
        final newTitle = title ?? currentTitle;
        final newContent = content ?? currentContent;
        
        state = NoteFormState.editing(
          title: newTitle,
          content: newContent,
          isValid: _validateInput(newTitle, newContent),
          validationErrors: _getValidationErrors(newTitle, newContent),
          originalNote: originalNote,
        );
      },
      orElse: () {
        // 編集状態でない場合は新規編集を開始
        startEditing(
          title: title ?? '',
          content: content ?? '',
        );
      },
    );
  }

  /// メモを保存する（新規作成または更新）
  Future<void> saveNote() async {
    // 現在の編集状態を取得
    String? title;
    String? content;
    NoteEntity? originalNote;
    
    state.maybeWhen(
      editing: (t, c, isValid, validationErrors, original) {
        if (!isValid) {
          // バリデーションエラーがある場合は保存しない
          return;
        }
        title = t;
        content = c;
        originalNote = original;
      },
      orElse: () => null,
    );

    if (title == null || content == null) {
      state = const NoteFormState.error('保存する内容がありません');
      return;
    }

    // 保存中状態に変更
    state = const NoteFormState.saving();

    try {
      NoteEntity savedNote;
      
      if (originalNote != null) {
        // 更新処理
        final updateNoteUseCase = await ref.read(updateNoteUseCaseProvider.future);
        savedNote = await updateNoteUseCase.call(
          id: originalNote!.id,
          title: title!,
          content: content!,
        );
      } else {
        // 新規作成処理
        final createNoteUseCase = await ref.read(createNoteUseCaseProvider.future);
        savedNote = await createNoteUseCase.call(
          title: title!,
          content: content!,
        );
      }

      // 保存完了状態に変更
      state = NoteFormState.saved(savedNote);
    } catch (e, stackTrace) {
      // エラー状態に変更
      state = NoteFormState.error(_formatErrorMessage(e));
      _logError(e, stackTrace, 'メモの保存に失敗しました');
    }
  }

  /// メモを削除する
  Future<void> deleteNote(String noteId) async {
    // 削除中状態に変更
    state = const NoteFormState.deleting();

    try {
      final deleteNoteUseCase = await ref.read(deleteNoteUseCaseProvider.future);
      await deleteNoteUseCase.call(noteId);

      // 削除完了状態に変更
      state = const NoteFormState.deleted();
    } catch (e, stackTrace) {
      // エラー状態に変更
      state = NoteFormState.error(_formatErrorMessage(e));
      _logError(e, stackTrace, 'メモの削除に失敗しました');
    }
  }

  /// 既存のメモを編集状態で読み込む
  Future<void> loadNoteForEditing(String noteId) async {
    try {
      final getNoteByIdUseCase = await ref.read(getNoteByIdUseCaseProvider.future);
      final note = await getNoteByIdUseCase.call(noteId);

      if (note != null) {
        startEditing(
          title: note.title,
          content: note.content,
          originalNote: note,
        );
      } else {
        state = const NoteFormState.error('メモが見つかりません');
      }
    } catch (e, stackTrace) {
      state = NoteFormState.error(_formatErrorMessage(e));
      _logError(e, stackTrace, 'メモの読み込みに失敗しました');
    }
  }

  /// フォームをリセットする
  void reset() {
    state = const NoteFormState.initial();
  }

  /// エラーをクリアして編集状態に戻る
  void clearError() {
    state.maybeWhen(
      error: (message) => state = const NoteFormState.initial(),
      orElse: () {
        // エラー状態でない場合は何もしない
      },
    );
  }

  /// 入力値のバリデーション
  bool _validateInput(String title, String content) {
    return title.trim().isNotEmpty && 
           content.trim().isNotEmpty &&
           title.trim().length <= 100 &&
           content.trim().length <= 10000;
  }

  /// バリデーションエラーのリストを取得
  List<String> _getValidationErrors(String title, String content) {
    final errors = <String>[];
    
    if (title.trim().isEmpty) {
      errors.add('タイトルを入力してください');
    } else if (title.trim().length > 100) {
      errors.add('タイトルは100文字以内で入力してください');
    }
    
    if (content.trim().isEmpty) {
      errors.add('内容を入力してください');
    } else if (content.trim().length > 10000) {
      errors.add('内容は10000文字以内で入力してください');
    }
    
    return errors;
  }

  /// 現在の状態が保存中かどうかを判定する
  bool get isSaving => state.maybeWhen(
    saving: () => true,
    orElse: () => false,
  );

  /// 現在の状態が削除中かどうかを判定する
  bool get isDeleting => state.maybeWhen(
    deleting: () => true,
    orElse: () => false,
  );

  /// 現在の状態にエラーがあるかどうかを判定する
  bool get hasError => state.maybeWhen(
    error: (message) => true,
    orElse: () => false,
  );

  /// 現在のエラーメッセージを取得する
  String? get errorMessage => state.maybeWhen(
    error: (message) => message,
    orElse: () => null,
  );

  /// 現在の編集内容が有効かどうかを判定する
  bool get isValid => state.maybeWhen(
    editing: (title, content, isValid, validationErrors, originalNote) => isValid,
    orElse: () => false,
  );

  /// 現在のバリデーションエラーを取得する
  List<String> get validationErrors => state.maybeWhen(
    editing: (title, content, isValid, validationErrors, originalNote) => 
        validationErrors ?? [],
    orElse: () => [],
  );

  /// 保存済みメモを取得する
  NoteEntity? get savedNote => state.maybeWhen(
    saved: (note) => note,
    orElse: () => null,
  );

  /// エラーメッセージをフォーマットする
  String _formatErrorMessage(Object error) {
    if (error is Exception) {
      final errorString = error.toString();
      
      // ValidationExceptionの場合、詳細メッセージを抽出
      if (errorString.contains('ValidationException') ||
          errorString.contains('ArgumentError')) {
        final match = RegExp(r': (.+)$').firstMatch(errorString);
        if (match != null) {
          return match.group(1) ?? '入力内容に問題があります';
        }
      }
      
      // RepositoryExceptionの場合
      if (errorString.contains('RepositoryException')) {
        final match = RegExp(r': (.+)$').firstMatch(errorString);
        if (match != null) {
          return match.group(1) ?? 'データの保存に失敗しました';
        }
      }
      
      return '操作に失敗しました';
    }
    
    return 'エラーが発生しました: ${error.toString()}';
  }

  /// エラーログを出力する
  void _logError(dynamic error, StackTrace stackTrace, String context) {
    // 実際のアプリではロギングライブラリを使用
    // 開発時のみログ出力（本番環境では適切なロギングライブラリを使用）
    // ignore: avoid_print
    print('NoteFormNotifier Error - $context: $error');
    // ignore: avoid_print
    print('StackTrace: $stackTrace');
  }

  /// 現在の状態情報を取得する（デバッグ用）
  Map<String, dynamic> getStateInfo() {
    return state.when(
      initial: () => {'status': 'initial'},
      editing: (title, content, isValid, validationErrors, originalNote) => {
        'status': 'editing',
        'title': title,
        'contentLength': content.length,
        'isValid': isValid,
        'validationErrors': validationErrors,
        'isUpdate': originalNote != null,
        'originalNoteId': originalNote?.id,
      },
      saving: () => {'status': 'saving'},
      saved: (note) => {
        'status': 'saved',
        'noteId': note.id,
        'title': note.title,
      },
      deleting: () => {'status': 'deleting'},
      deleted: () => {'status': 'deleted'},
      error: (message) => {'status': 'error', 'message': message},
    );
  }
}
