import 'package:flutter/material.dart';

class MyAlertBox extends StatelessWidget {
  final inputController;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final String hintText;

  const MyAlertBox({
    super.key,
    required this.hintText,
    required this.inputController,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.deepPurple,
      content: TextField(
        controller: inputController,
        style: TextStyle(color: Colors.grey.shade300),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white.withAlpha(100)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
      actions: [
        MaterialButton(
          onPressed: onSave,
          color: Colors.deepPurple[100],
          child: Text("Save", style: TextStyle(color: Colors.black)),
        ),
        MaterialButton(
          onPressed: onCancel,
          color: Colors.deepPurple[100],
          child: Text("Cancel", style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }
}
