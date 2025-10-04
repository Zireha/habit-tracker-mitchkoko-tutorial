import 'package:flutter/material.dart';

class AddFloatingActionButton extends StatelessWidget {
  final Function()? onPressed;

  const AddFloatingActionButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(onPressed: onPressed, child: Icon(Icons.add));
  }
}
