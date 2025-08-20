import 'package:flutter/material.dart';
import 'package:note_app/notepad/noteForm.dart';

class NoteCard extends StatelessWidget {
  final String name;
  final String notes;
  final String guid;

  final VoidCallback callback;

  const NoteCard(this.name, this.notes, this.guid, this.callback, {super.key});

  void onCardClick(context) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => NoteForm(noteName: name, note: notes, guid: guid,),
        )).then((_) {
        callback();
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SizedBox(
        width: 250,
        child:  InkWell(
        onTap: () => {
          onCardClick(context)
        },
        child: Card(
          color: Color.fromARGB(255, 143, 58, 192),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Align(
                  alignment: AlignmentGeometry.topLeft,
                  child: Text(
                    name,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    )
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    height: 60,
                    child: Text(
                      notes, 
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                      )
                    ),
                  )
                )
              ],
            )
            ),
        ),
      ));
    });
  }
}