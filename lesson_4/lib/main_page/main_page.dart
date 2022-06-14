import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:whe/main_page/widgets/card_widget.dart';
import 'package:whe/main_page/widgets/google_account_widget.dart';
import 'package:whe/main_page/widgets/write_note_widget.dart';

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
    String? name = 'user';
    if (user != null) {
      name = user.displayName ?? '';
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Notes'),
          backgroundColor: Colors.brown[200],
        ),
        body: Center(
            child: Column(children: [
          const GoogleAccount(),
          Stack(
            children: [
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('items')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: Text("No elements"));
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final elements =
                              snapshot.data!.docs[index].get('elements');
                          final name = snapshot.data!.docs[index].get('email');
                          final title =
                              snapshot.data!.docs[index].get('titles');
                          final indexNote = index;
                          return CardWidget(
                              title: title,
                              body: elements,
                              index: indexNote,
                              userNote: name);
                        },
                      );
                    }
                  }),
             WriteNoteWidget(nameNote: name),
            ],
          ),
        ])),
      ),
    );
  }
}
