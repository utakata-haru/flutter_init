import 'package:freezed_annotation/freezed_annotation.dart';
import '../../1_domain/1_entities/file_history.dart';

part 'file_history_model.freezed.dart';
part 'file_history_model.g.dart';

@freezed
abstract class FileHistoryModel with _$FileHistoryModel {
  const factory FileHistoryModel({
    required String id,
    required String path,
    required DateTime lastAccessed,
  }) = _FileHistoryModel;

  factory FileHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$FileHistoryModelFromJson(json);

  factory FileHistoryModel.fromEntity(FileHistory entity) {
    return FileHistoryModel(
      id: entity.id,
      path: entity.path,
      lastAccessed: entity.lastAccessed,
    );
  }
}

extension FileHistoryModelX on FileHistoryModel {
  FileHistory toEntity() {
    return FileHistory(
      id: id,
      path: path,
      lastAccessed: lastAccessed,
    );
  }
}
