import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../1_domain/2_repositories/file_history_repository.dart';
import '../../2_infrastructure/3_repositories/file_history_repository_impl.dart';

part 'file_history_providers.g.dart';

@riverpod
FileHistoryRepository fileHistoryRepository(Ref ref) {
  return FileHistoryRepositoryImpl();
}
