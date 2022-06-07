import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../login_page/widgets/google_sign_widget.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

class GoogleAccount extends StatefulWidget {
  const GoogleAccount({Key? key}) : super(key: key);

  @override
  State<GoogleAccount> createState() => GoogleAccountState();
}

class GoogleAccountState extends State<GoogleAccount> {
  static GoogleSignInAccount? currentUser;

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
