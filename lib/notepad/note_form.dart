import 'package:flutter/material.dart';
import 'package:note_app/notepad/text_form_input.dart';
import 'package:note_app/notepad/text_input.dart';
import 'package:note_app/user_note.dart';
import 'package:note_app/userSettingsKeys.dart';
import 'package:note_app/user_notes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class NoteForm extends StatefulWidget {
  final String? noteName;
  final String? note;
  final String? guid;

  const NoteForm({this.noteName = '', this.note = '', this.guid, super.key});

  @override
  State<NoteForm> createState() => NoteFormState();
}

class NoteFormState extends State<NoteForm> {
  TextEditingController titleController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.noteName ?? "";
    notesController.text = widget.note ?? "";
  }

  Future<void> deleteNote() async {
    final prefs = await SharedPreferences.getInstance();
    String? settingString = prefs.getString(UserSettingsKeys.userNotes);
    if (settingString == null) return;

    UserNotes userNotesList = UserNotes.fromJson(jsonDecode(settingString));
    int noteExist = userNotesList.notes.indexWhere((userNote) =>  userNote.guid == widget.guid);
    if (noteExist < 0) return;

    userNotesList.notes.removeAt(noteExist);
    await prefs.setString(UserSettingsKeys.userNotes, jsonEncode(userNotesList.toJson()));
    if (mounted) {
      Navigator.pop(context);
    }
  }

  Future<void> saveNotes() async {
    final prefs = await SharedPreferences.getInstance();

    final UserNote noteInput = UserNote(titleController.value.text, notesController.value.text, widget.guid);
    UserNotes userNotesList = UserNotes([]);
    String? settingString = prefs.getString(UserSettingsKeys.userNotes);

    if (settingString == null) {
      userNotesList.notes.add(noteInput);
      await prefs.setString(UserSettingsKeys.userNotes, jsonEncode(userNotesList.toJson()));
      return;
    }
    
    userNotesList = UserNotes.fromJson(jsonDecode(settingString));
    int noteIndex = userNotesList.notes.indexWhere((userNote) =>  userNote.guid == widget.guid);
    print(noteIndex);

    // Note exists
    if (noteIndex > -1) {
      UserNote foundUserNote = userNotesList.notes.firstWhere((userNote) =>  userNote.guid == widget.guid);
      foundUserNote.name = titleController.value.text;
      foundUserNote.note = notesController.value.text;
      userNotesList.notes[noteIndex] = foundUserNote;
      await prefs.setString(UserSettingsKeys.userNotes, jsonEncode(userNotesList.toJson()));
      return;
    }

    userNotesList.notes.add(noteInput);
    await prefs.setString(UserSettingsKeys.userNotes, jsonEncode(userNotesList.toJson()));
  }

 @override
 Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text('New note'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: saveNotes,
        child: const Icon(Icons.save),
        ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextInput(titleController),
              SizedBox(height: 8),
              TextFormInput(notesController),
              SizedBox(height: 8,),
              if (widget.guid != null) ...[
                TextButton(
                  onPressed: deleteNote, 
                  child: const Icon(Icons.delete),
                )
              ]

            ],
          ),
        ),
      )
    );
  }
}

