import 'package:flutter/material.dart';
import 'package:note_app/notepad/noteForm.dart';

class NoteCard extends StatelessWidget {
  final String name;
  final String notes;
  final String guid;

  final VoidCallback callback;

  const NoteCard(this.name, this.notes, this.guid, this.callback, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        Navigator.push(context, MaterialPageRoute(builder: (context) => NoteForm(noteName: name, note: notes, guid: guid,),)).then((_) {
          this.callback();
        })
      },
      child: Card(
        color: Color.fromARGB(0, 109, 65, 231),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text(name),
              SizedBox(
                child: Text(notes),
              )
            ],
          )
          ),
      ),
    );
  }
}