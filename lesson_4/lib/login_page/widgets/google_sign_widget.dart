import 'package:flutter/material.dart';
import 'package:whe/utils/text_styles/Texts_styles.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
class GoogleSign extends StatefulWidget {
final Function callBack;

const GoogleSign({Key? key, required this.callBack}) : super(key: key);

@override
State<GoogleSign> createState() => GoogleSignState();
}

class GoogleSignState extends State<GoogleSign> {
  static GoogleSignInAccount? currentUser;

  @override
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
    GoogleSignInAccount? user = currentUser;
    if (user != null) {
      return Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GoogleUserCircleAvatar(
              identity: user,
            ),
            const SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.displayName ?? '',
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18)),
                const SizedBox(
                  height: 5,
                ),
                Text(user.email,
                    style: const TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                        fontSize: 15)),
              ],
            )
          ],
        ),
        const SizedBox(height: 10),
        const Text("Singed in successfully",
            style: TextStyle(color: Colors.white, fontSize: 16)),
        ElevatedButton(
            onPressed: singOut,
            style: ElevatedButton.styleFrom(
              primary: Colors.white70,
            ),
            child: const Text(
              'Sing out',
              style: TextStyle(color: Colors.black),
            ))
      ]);
    } else {
      return Column(
        children: [
          const Text('You are not singed in Google account',
              style: TextStyle(color: Colors.white, fontSize: 16)),
          ElevatedButton(
              onPressed: singIn,
              style: ElevatedButton.styleFrom(
                primary: Colors.white70,
              ),
              child: const Text('Google Sing In',
                  style: TextStyle(color: Colors.black))),
        ],
      );
    }
  }

  void singOut() {
    _googleSignIn.disconnect();
    widget.callBack();
  }

  Future<void> singIn() async {
    try {
      await _googleSignIn.signIn();
      widget.callBack();
    } catch (e) {
      print('error sing in $e');
    }
  }
}
