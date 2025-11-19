import '../1_entities/file_history.dart';

abstract interface class FileHistoryRepository {
  Future<List<FileHistory>> getHistory();
  Future<void> addHistory(FileHistory history);
  Future<void> deleteHistory(String id);
  Future<void> clearHistory();
}
