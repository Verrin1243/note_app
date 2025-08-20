// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_notes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserNotes _$UserNotesFromJson(Map<String, dynamic> json) => UserNotes(
  (json['notes'] as List<dynamic>)
      .map((e) => UserNote.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$UserNotesToJson(UserNotes instance) => <String, dynamic>{
  'notes': instance.notes,
};
