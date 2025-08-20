import 'dart:convert';
import 'package:note_app/user_notes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:note_app/components/noteCard.dart';
import 'package:note_app/notepad/noteForm.dart';
import 'package:note_app/user_note.dart';
import 'package:note_app/userSettingsKeys.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
 
  const MyApp({super.key});
  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  UserNotes _userNotes = UserNotes([]);

  @override
  void initState() {
    super.initState();
    _getUserNotes();
  }

  Future<void> _getUserNotes() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      final String? userSettingsString = prefs.getString(UserSettingsKeys.userNotes);
      if (userSettingsString == null) return;
      _userNotes = UserNotes.fromJson(jsonDecode(userSettingsString));
    });
  }

  Future<void> goNewNote() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => NoteForm(),)).then(
      (_) {
        _getUserNotes();
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: 
            List.generate(_userNotes.notes.length, (index){
              return NoteCard(_userNotes.notes[index].name, _userNotes.notes[index].note as String, _userNotes.notes[index].guid as String, _getUserNotes);
            })
          ,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: goNewNote,
        tooltip: 'Increment ${_userNotes.notes.length}',
        child: const Icon(Icons.add),
      ),
    );
  }
}
