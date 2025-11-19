// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FileHistoryModel _$FileHistoryModelFromJson(Map<String, dynamic> json) =>
    _FileHistoryModel(
      id: json['id'] as String,
      path: json['path'] as String,
      lastAccessed: DateTime.parse(json['lastAccessed'] as String),
    );

Map<String, dynamic> _$FileHistoryModelToJson(_FileHistoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'path': instance.path,
      'lastAccessed': instance.lastAccessed.toIso8601String(),
    };
