import 'package:freezed_annotation/freezed_annotation.dart';

part 'file_history.freezed.dart';

@freezed
abstract class FileHistory with _$FileHistory {
  const factory FileHistory({
    required String id,
    required String path,
    required DateTime lastAccessed,
  }) = _FileHistory;
}
