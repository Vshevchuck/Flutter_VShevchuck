import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:whe/main_page/widgets/card_widget.dart';
import 'package:whe/main_page/widgets/google_account_widget.dart';

import '../login_page/widgets/google_sign_widget.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  GoogleSignInAccount? currentUser;

  void initFireBase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    _googleSignIn.onCurrentUserChanged.listen((account) {
      setState(() {
        currentUser = account;
      });
    });
    initFireBase();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    GoogleSignInAccount? user = GoogleSignState.currentUser;
    String? name='user';
    if(user!=null)
      {
        name=user.displayName ?? '';
      }
    var screenHeight = (MediaQuery
        .of(context)
        .size
        .height);
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Notes'),
            backgroundColor: Colors.brown[200],
          ),
          body: SingleChildScrollView(
            child: Center(
                child: Column(children: [
                  GoogleAccount(),
                  Stack(
                    children: [
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('items')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData)
                              return const Text("No elements");
                            return ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (BuildContext context, index) {
                                final elements =
                                snapshot.data!.docs[index].get('elements');
                                final name =
                                snapshot.data!.docs[index].get('email');
                                final title =
                                snapshot.data!.docs[index].get('titles');
                                final indexNote = index;
                                return CardWidget(title: title,
                                    body: elements,
                                    index: indexNote,userNote: name);
                              },
                            );
                          }),
                      WriteNoteWidget(nameNote:name),
                    ],
                  ),
                ])),
          )),
    );
  }
}

class WriteNoteWidget extends StatefulWidget {
  final String nameNote;
  const WriteNoteWidget({Key? key, required this.nameNote}) : super(key: key);

  @override
  State<WriteNoteWidget> createState() => _WriteNoteWidgetState();
}

class _WriteNoteWidgetState extends State<WriteNoteWidget> {
  @override
  Widget build(BuildContext context) {
    String name= widget.nameNote;
    var screenHeight = (MediaQuery
        .of(context)
        .size
        .height);
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
    var screenHeight = (MediaQuery
        .of(context)
        .size
        .height);
    double height = GoogleSignState.currentUser == null
        ? screenHeight / 1.5
        : screenHeight / 1.7;
    return height;
  }

  showAlert() {
    String title = '';
    String body = '';
    // set up the button
    Widget addButton = TextButton(
      child: const Text("Add"),
      onPressed: () {
        if (body != '') {
          FirebaseFirestore.instance
              .collection('items')
              .add({'elements': body, 'titles': title, 'email': widget.nameNote});
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
