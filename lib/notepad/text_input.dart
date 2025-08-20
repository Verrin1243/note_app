import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  final TextEditingController inputController;

  const TextInput(this.inputController, {super.key,});

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return TextField(
      controller: widget.inputController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4))
          ),
        hint: Text('title'),
      ),
    );
  }
}