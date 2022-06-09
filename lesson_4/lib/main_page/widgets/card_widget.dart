import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:whe/main_page/widgets/rewrite_note_widget.dart';

class CardWidget extends StatelessWidget {
  final String title;
  final String body;
  final int index;
  final String userNote;

  const CardWidget(
      {Key? key,
      required this.userNote,
      required this.index,
      required this.title,
      required this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
          color: Colors.grey[300],
          child: Column(
            children: [
              Container(
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text('$title',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500)),
                        ),
                        Text(userNote),
                      ],
                    ),
                  )),
              const SizedBox(height: 8),
              SingleChildScrollView(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 75,
                    decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                        width: 1.0,
                        color: Colors.brown.shade200,
                      )),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(bottom: 8.0, left: 8.0),
                            child: Text(body,
                                style: const TextStyle(color: Colors.black)),
                          ),
                        ),
                        ReWriteNoteWidget(
                            nameNote: userNote,
                            title: title,
                            index: index,
                            body: body),
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('items')
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              return IconButton(
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection('items')
                                        .doc(snapshot.data!.docs[index].id)
                                        .delete();
                                    //FirebaseFirestore.instance
                                    //.collection('items')
                                    //.doc(snapshot.data!.docs[index].id).set({'elements': 'ss'});
                                  },
                                  icon: const Icon(Icons.remove_rounded));
                            })
                      ],
                    )),
              )
            ],
          )),
    );
  }
}
