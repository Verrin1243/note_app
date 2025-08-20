import 'package:flutter/material.dart';

class TextFormInput extends StatefulWidget {
  final TextEditingController textFormInputController;

  const TextFormInput(this.textFormInputController, {super.key});

  @override
  State<TextFormInput> createState() => _TextFormInputState();

}

class _TextFormInputState extends State<TextFormInput> {
  final textFormController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      maxLines: 20,
      controller: widget.textFormInputController,
          decoration: InputDecoration(
          border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4))
        ),
        hint: Text('notes...'),
      ),
    );
  }
}