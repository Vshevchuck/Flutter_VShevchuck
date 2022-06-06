
import 'package:flutter/material.dart';

class GoToNotes extends StatefulWidget {
  const GoToNotes({Key? key}) : super(key: key);

  @override
  State<GoToNotes> createState() => _GoToNotesState();
}

class _GoToNotesState extends State<GoToNotes> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: goToNotes,
        style: ElevatedButton.styleFrom(
          primary: Colors.white70,
        ),
        child: const Text(
          'Go to notes',
          style: TextStyle(color: Colors.black),
        ));
  }

  void goToNotes() {
    Navigator.pushNamed(context, '/main');
  }
}
