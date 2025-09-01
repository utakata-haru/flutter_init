// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NoteEntityImpl _$$NoteEntityImplFromJson(Map<String, dynamic> json) =>
    _$NoteEntityImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$NoteEntityImplToJson(_$NoteEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
