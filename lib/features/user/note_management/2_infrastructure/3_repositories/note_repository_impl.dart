import '../../1_domain/1_entities/note_entity.dart';
import '../../1_domain/2_repositories/note_repository.dart';
import '../2_data_sources/1_local/note_local_data_source.dart';
import '../1_models/note_model.dart';

/// メモリポジトリ実装クラス
/// 
/// ドメイン層のNoteRepositoryインターフェースを実装し、
/// ローカルデータソースを使用してメモデータの永続化を実現します。
class NoteRepositoryImpl implements NoteRepository {
  final NoteLocalDataSource _localDataSource;

  NoteRepositoryImpl(this._localDataSource);

  @override
  Future<NoteEntity?> getNoteById(String id) async {
    try {
      final noteModel = await _localDataSource.getNoteById(id);
      return noteModel?.toEntity();
    } on LocalDataSourceException catch (e) {
      throw RepositoryException('メモの取得に失敗しました: ${e.message}');
    } catch (e) {
      throw RepositoryException('予期しないエラーが発生しました: $e');
    }
  }

  @override
  Future<List<NoteEntity>> getNotes({int? limit, int? offset}) async {
    try {
      final noteModels = await _localDataSource.getAllNotes(
        limit: limit,
        offset: offset,
      );
      return noteModels.map((model) => model.toEntity()).toList();
    } on LocalDataSourceException catch (e) {
      throw RepositoryException('メモ一覧の取得に失敗しました: ${e.message}');
    } catch (e) {
      throw RepositoryException('予期しないエラーが発生しました: $e');
    }
  }

  @override
  Future<List<NoteEntity>> searchNotes(
    String query, {
    int? limit,
    int? offset,
  }) async {
    try {
      final noteModels = await _localDataSource.searchNotes(
        query,
        limit: limit,
        offset: offset,
      );
      return noteModels.map((model) => model.toEntity()).toList();
    } on LocalDataSourceException catch (e) {
      throw RepositoryException('メモ検索に失敗しました: ${e.message}');
    } catch (e) {
      throw RepositoryException('予期しないエラーが発生しました: $e');
    }
  }

  @override
  Future<NoteEntity> createNote(NoteEntity note) async {
    try {
      // エンティティをモデルに変換
      final noteModel = NoteModel.fromEntity(note);
      
      // ローカルデータソースに保存
      await _localDataSource.saveNote(noteModel);
      
      // 保存されたデータを再取得して返す（DBで自動生成された値を反映）
      final savedModel = await _localDataSource.getNoteById(note.id);
      if (savedModel == null) {
        throw RepositoryException('保存したメモの取得に失敗しました');
      }
      
      return savedModel.toEntity();
    } on LocalDataSourceException catch (e) {
      throw RepositoryException('メモの作成に失敗しました: ${e.message}');
    } catch (e) {
      throw RepositoryException('予期しないエラーが発生しました: $e');
    }
  }

  @override
  Future<NoteEntity> updateNote(NoteEntity note) async {
    try {
      // メモの存在確認
      final exists = await _localDataSource.noteExists(note.id);
      if (!exists) {
        throw RepositoryException('更新対象のメモが見つかりません: ${note.id}');
      }

      // エンティティをモデルに変換
      final noteModel = NoteModel.fromEntity(note);
      
      // ローカルデータソースで更新
      await _localDataSource.updateNote(noteModel);
      
      // 更新されたデータを再取得して返す
      final updatedModel = await _localDataSource.getNoteById(note.id);
      if (updatedModel == null) {
        throw RepositoryException('更新したメモの取得に失敗しました');
      }
      
      return updatedModel.toEntity();
    } on LocalDataSourceException catch (e) {
      throw RepositoryException('メモの更新に失敗しました: ${e.message}');
    } catch (e) {
      throw RepositoryException('予期しないエラーが発生しました: $e');
    }
  }

  @override
  Future<void> deleteNote(String id) async {
    try {
      // メモの存在確認
      final exists = await _localDataSource.noteExists(id);
      if (!exists) {
        throw RepositoryException('削除対象のメモが見つかりません: $id');
      }

      // ローカルデータソースから削除
      await _localDataSource.deleteNote(id);
    } on LocalDataSourceException catch (e) {
      throw RepositoryException('メモの削除に失敗しました: ${e.message}');
    } catch (e) {
      throw RepositoryException('予期しないエラーが発生しました: $e');
    }
  }

  @override
  Future<void> deleteAllNotes() async {
    try {
      await _localDataSource.deleteAllNotes();
    } on LocalDataSourceException catch (e) {
      throw RepositoryException('全メモの削除に失敗しました: ${e.message}');
    } catch (e) {
      throw RepositoryException('予期しないエラーが発生しました: $e');
    }
  }

  @override
  Future<int> getNotesCount() async {
    try {
      return await _localDataSource.getNotesCount();
    } on LocalDataSourceException catch (e) {
      throw RepositoryException('メモ数の取得に失敗しました: ${e.message}');
    } catch (e) {
      throw RepositoryException('予期しないエラーが発生しました: $e');
    }
  }

  @override
  Future<List<NoteEntity>> getRecentlyUpdatedNotes({int limit = 10}) async {
    try {
      final noteModels = await _localDataSource.getRecentlyUpdatedNotes(
        limit: limit,
      );
      return noteModels.map((model) => model.toEntity()).toList();
    } on LocalDataSourceException catch (e) {
      throw RepositoryException('最近更新されたメモの取得に失敗しました: ${e.message}');
    } catch (e) {
      throw RepositoryException('予期しないエラーが発生しました: $e');
    }
  }

  @override
  Future<List<NoteEntity>> getRecentlyCreatedNotes({int daysAgo = 7}) async {
    try {
      final noteModels = await _localDataSource.getRecentlyCreatedNotes(
        daysAgo: daysAgo,
      );
      return noteModels.map((model) => model.toEntity()).toList();
    } on LocalDataSourceException catch (e) {
      throw RepositoryException('最近作成されたメモの取得に失敗しました: ${e.message}');
    } catch (e) {
      throw RepositoryException('予期しないエラーが発生しました: $e');
    }
  }

  /// 複数のメモを一括保存する（バッチ処理用）
  /// 
  /// [notes] 保存するメモのリスト
  /// 
  /// 注意: このメソッドはドメインインターフェースには含まれていませんが、
  /// パフォーマンス向上のために実装されています。
  Future<void> saveNotesBatch(List<NoteEntity> notes) async {
    try {
      final noteModels = notes.map((entity) => NoteModel.fromEntity(entity)).toList();
      await _localDataSource.saveNotes(noteModels);
    } on LocalDataSourceException catch (e) {
      throw RepositoryException('メモの一括保存に失敗しました: ${e.message}');
    } catch (e) {
      throw RepositoryException('予期しないエラーが発生しました: $e');
    }
  }

  /// データベースの健全性をチェックする
  /// 
  /// Returns: データベースが正常な場合はtrue
  Future<bool> checkDatabaseHealth() async {
    try {
      final impl = _localDataSource;
      if (impl is NoteLocalDataSourceImpl) {
        return await impl.checkDatabaseIntegrity();
      }
      return true; // 他の実装では常にtrueを返す
    } catch (e) {
      return false;
    }
  }

  /// データベースを最適化する
  /// 
  /// 定期的なメンテナンス処理として使用します。
  Future<void> optimizeDatabase() async {
    try {
      final impl = _localDataSource;
      if (impl is NoteLocalDataSourceImpl) {
        await impl.optimizeDatabase();
      }
    } on LocalDataSourceException catch (e) {
      throw RepositoryException('データベースの最適化に失敗しました: ${e.message}');
    } catch (e) {
      throw RepositoryException('予期しないエラーが発生しました: $e');
    }
  }

  /// ストレージの使用状況を取得する
  /// 
  /// Returns: 統計情報のマップ
  Future<Map<String, dynamic>> getStorageStats() async {
    try {
      final impl = _localDataSource;
      if (impl is NoteLocalDataSourceImpl) {
        return await impl.getTableStats();
      }
      return {'totalNotes': 0, 'databaseSize': 0};
    } on LocalDataSourceException catch (e) {
      throw RepositoryException('統計情報の取得に失敗しました: ${e.message}');
    } catch (e) {
      throw RepositoryException('予期しないエラーが発生しました: $e');
    }
  }
}

/// リポジトリ例外
class RepositoryException implements Exception {
  final String message;
  RepositoryException(this.message);

  @override
  String toString() => 'RepositoryException: $message';
}
