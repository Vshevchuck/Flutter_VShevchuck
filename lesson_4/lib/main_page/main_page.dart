import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:whe/main_page/widgets/card_widget.dart';
import 'package:whe/main_page/widgets/google_account_widget.dart';

import '../login_page/login_page.dart';
import '../login_page/widgets/google_sign_widget.dart';
import '../login_page/widgets/google_sign_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  void initFireBase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    super.initState();
    initFireBase();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = (MediaQuery.of(context).size.height);
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Notes'),
            backgroundColor: Colors.brown[200],
          ),
          body: Center(
              child: Column(children: [
            GoogleAccount(),
            ElevatedButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('items')
                      .add({'elements': 'element', 'titles': 'title'});
                },
                child: const Text("Add")),
            StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('items').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  return ElevatedButton(
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection('items')
                          .doc(snapshot
                              .data!.docs[snapshot.data!.docs.length - 1].id)
                          .delete();
                    },
                    child: const Text("Dell last"),
                  );
                }),
            Stack(
              children: [
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('items')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) return const Text("No elements");
                      return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, index) {
                          final elements =
                              snapshot.data!.docs[index].get('elements');
                          final title =
                              snapshot.data!.docs[index].get('titles');
                          return ListTile(
                              title: Column(
                            children: [
                              Text('$title-$index'),
                              Text('$elements'),
                            ],
                          ));
                        },
                      );
                    }),CardWidget(title: "test", body: "just watch"),
                Column(
                  children: [
                    SizedBox(height: GoogleSignState.currentUser == null ?  screenHeight / 1.5 : screenHeight / 1.7),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        iconSize: 35,
                        onPressed: showAlert,
                        icon: const Icon(Icons.pending_outlined),
                      ),
                    )
                  ],
                )
              ],
            ),
          ]))),
    );
  }
  showAlert(){
    // set up the button
    Widget addButton = TextButton(
      child: const Text("Add"),
      onPressed:() {Navigator.of(context).pop();},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const TextField(decoration: InputDecoration(
          hintText: 'Title',
      )),
      content: TextField(decoration: InputDecoration(
          labelText: 'Body',
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Colors.grey),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Colors.yellow),
            borderRadius: BorderRadius.circular(15),
          )),),
      actions: [
        addButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
