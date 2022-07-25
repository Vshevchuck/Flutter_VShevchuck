import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../login_page/widgets/google_sign_widget.dart';

class WriteNoteWidget extends StatefulWidget {
  final String nameNote;

  const WriteNoteWidget({Key? key, required this.nameNote}) : super(key: key);

  @override
  State<WriteNoteWidget> createState() => _WriteNoteWidgetState();
}

class _WriteNoteWidgetState extends State<WriteNoteWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: getHeightIcon()),
        Align(
          alignment: Alignment.bottomRight,
          child: IconButton(
            iconSize: 35,
            onPressed: showAlert,
            icon: const Icon(Icons.pending_outlined),
          ),
        )
      ],
    );
  }

  double getHeightIcon() {
    var screenHeight = (MediaQuery.of(context).size.height);
    double height = GoogleSignState.currentUser == null
        ? screenHeight / 1.3
        : screenHeight / 1.4;
    return height;
  }

  showAlert() {
    String title = '';
    String body = '';
    Widget addButton = TextButton(
      child: const Text("Add"),
      onPressed: () {
        if (body != '') {
          FirebaseFirestore.instance.collection('items').add(
              {'elements': body, 'titles': title, 'email': widget.nameNote});
          Navigator.of(context).pop();
        }
      },
    );

    AlertDialog alert = AlertDialog(
      title: TextField(
          onChanged: (String str) {
            title = str;
          },
          decoration: const InputDecoration(
            hintText: 'Title',
          )),
      content: TextField(
        onChanged: (String str) {
          body = str;
        },
        decoration: InputDecoration(
          // Added this
            labelText: 'Body',
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: Colors.grey),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: Colors.yellow),
              borderRadius: BorderRadius.circular(15),
            )),
      ),
      actions: [
        addButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


}
