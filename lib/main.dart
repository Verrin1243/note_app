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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

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
