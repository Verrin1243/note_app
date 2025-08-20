import 'package:json_annotation/json_annotation.dart';
import 'package:note_app/user_note.dart';

part 'user_notes.g.dart';

@JsonSerializable()
class UserNotes {
  List<UserNote> notes;

  UserNotes(this.notes);

  factory UserNotes.fromJson(Map<String, dynamic> json) => _$UserNotesFromJson(json);

  Map<String, dynamic> toJson() => _$UserNotesToJson(this);

  void operator [](int other) {}
}