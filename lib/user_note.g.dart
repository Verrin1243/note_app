// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserNote _$UserNoteFromJson(Map<String, dynamic> json) => UserNote(
  json['name'] as String,
  json['note'] as String?,
  json['guid'] as String?,
);

Map<String, dynamic> _$UserNoteToJson(UserNote instance) => <String, dynamic>{
  'name': instance.name,
  'note': instance.note,
  'guid': instance.guid,
};
