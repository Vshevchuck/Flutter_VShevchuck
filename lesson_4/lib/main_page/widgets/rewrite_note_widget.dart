import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReWriteNoteWidget extends StatefulWidget {
  final String nameNote;
  final String title;
  final String body;
  final int index;

  const ReWriteNoteWidget(
      {Key? key,
      required this.nameNote,
      required this.index,
      required this.title,
      required this.body})
      : super(key: key);

  @override
  State<ReWriteNoteWidget> createState() => _ReWriteNoteWidgetState();
}

class _ReWriteNoteWidgetState extends State<ReWriteNoteWidget> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: showAlert, icon: const Icon(Icons.mark_chat_unread_rounded));
  }

  showAlert() {
    String title = widget.title;
    String body = widget.body;
    Widget addButton = StreamBuilder(
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return TextButton(
            child: const Text("Rewrite"),
            onPressed: () {
              if (body != '') {
                FirebaseFirestore.instance
                    .collection('items')
                    .doc(snapshot.data!.docs[widget.index].id)
                    .set({
                  'elements': body,
                  'titles': title,
                  'email': widget.nameNote
                });
                Navigator.of(context).pop();
              }
            },
          );
        });

    AlertDialog alert = AlertDialog(
      title: TextField(
          onChanged: (String str) {
            title = str;
          },
          controller: TextEditingController(text: title)),
      content: TextField(
        onChanged: (String str) {
          body = str;
        },
        controller: TextEditingController(text: body),
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
