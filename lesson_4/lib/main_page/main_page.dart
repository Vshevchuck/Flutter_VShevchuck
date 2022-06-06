import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../login_page/login_page.dart';
import '../login_page/widgets/google_sign_widget.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

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

  void initState() {
    super.initState();
    initFireBase();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: const Text('Notes')),
        backgroundColor: Colors.brown[200],
      ),
      body: SingleChildScrollView(
          child: Center(
              child: Column(children: [
        GoogleAccount(),
        ElevatedButton(
            onPressed: () {
              FirebaseFirestore.instance
                  .collection('items')
                  .add({'elements': 'element', 'titles': 'title'});
            },
            child: Text("Add")),
        StreamBuilder(
            stream: FirebaseFirestore.instance.collection('items').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              return ElevatedButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('items')
                      .doc(snapshot
                          .data!.docs[snapshot.data!.docs.length - 1].id)
                      .delete();
                },
                child: Text("Dell last"),
              );
            }),
        StreamBuilder(
            stream: FirebaseFirestore.instance.collection('items').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return Text("No elements");
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  final elements = snapshot.data!.docs[index].get('elements');
                  final title = snapshot.data!.docs[index].get('titles');
                  return Column(
                    children: [
                      Text('$title-$index'),
                      Text('$elements'),
                    ],
                  );
                },
              );
            }),

      ]))),
    ));
  }
}

class GoogleAccount extends StatefulWidget {
  const GoogleAccount({Key? key}) : super(key: key);

  @override
  State<GoogleAccount> createState() => _GoogleAccountState();
}

class _GoogleAccountState extends State<GoogleAccount> {
  GoogleSignInAccount? currentUser;

  void initState() {
    _googleSignIn.onCurrentUserChanged.listen((account) {
      setState(() {
        currentUser = account;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GoogleSignInAccount? user = GoogleSignState.currentUser;
    if (user != null) {
      return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        ListTile(
          leading: GoogleUserCircleAvatar(
            identity: user,
          ),
          title: Text(user.displayName ?? ''),
          subtitle: Text(user.email),
        )
      ]);
    } else {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Align(
            alignment: Alignment.center,
            child: Text('You are not signed in with a google account',
                style: TextStyle(fontSize: 17))),
      );
    }
  }
}
