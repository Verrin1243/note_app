import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'user_note.g.dart';

@JsonSerializable()
class UserNote {
  String name;

  String? note;

  String? guid;

  UserNote(this.name, this.note, [this.guid]) {
    if (this.guid == null) {
      this.guid = Uuid().v4();
      return;
    }
    this.guid = guid;
  }

  factory UserNote.fromJson(Map<String, dynamic> json) => _$UserNoteFromJson(json);

  Map<String, dynamic> toJson() => _$UserNoteToJson(this);
}