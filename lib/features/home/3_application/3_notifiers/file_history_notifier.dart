import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../../1_domain/1_entities/file_history.dart';
import '../2_providers/file_history_providers.dart';

part 'file_history_notifier.g.dart';

@riverpod
class FileHistoryNotifier extends _$FileHistoryNotifier {
  @override
  Future<List<FileHistory>> build() async {
    return _loadHistory();
  }

  Future<List<FileHistory>> _loadHistory() async {
    final repository = ref.read(fileHistoryRepositoryProvider);
    return repository.getHistory();
  }

  Future<void> addFile(String path) async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(fileHistoryRepositoryProvider);
      final history = FileHistory(
        id: const Uuid().v4(),
        path: path,
        lastAccessed: DateTime.now(),
      );
      await repository.addHistory(history);
      state = AsyncValue.data(await _loadHistory());
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> removeFile(String id) async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(fileHistoryRepositoryProvider);
      await repository.deleteHistory(id);
      state = AsyncValue.data(await _loadHistory());
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
  
  Future<void> clearHistory() async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(fileHistoryRepositoryProvider);
      await repository.clearHistory();
      state = const AsyncValue.data([]);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
