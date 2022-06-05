import 'package:flutter/material.dart';
import 'package:whe/utils/text_styles/Texts_styles.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = (MediaQuery.of(context).size.height);
    return SafeArea(
        child: Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/background_logo.jpg"),
              fit: BoxFit.cover),
        ),
        child: Container(
          height: screenHeight,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: screenHeight / 1.2,
              child: Column(
                children: [
                  const Text(
                    'Welocme Back!',
                    style: TextsStyles.welcomeTextStyle,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Sign in to your profile",
                    style: TextsStyles.signInTestStyle,
                  ),
                  const SizedBox(height: 32.0),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.0),
                    child: TextField(
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w300),
                        decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.white70),
                            hintText: 'Username',
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2.0, color: Colors.white)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.0, color: Colors.white60)),
                            isCollapsed: true,
                            contentPadding: EdgeInsets.only(top: 16.0),
                            prefixIcon: Icon(
                              Icons.account_circle_rounded,
                              color: Colors.white60,
                            ))),
                  ),
                  SizedBox(height: 16.0),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.0),
                    child: TextField(
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w300),
                        obscureText: true,
                        decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.white70),
                            hintText: 'password',
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2.0, color: Colors.white)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.0, color: Colors.white60)),
                            isCollapsed: true,
                            contentPadding: EdgeInsets.only(top: 16.0),
                            prefixIcon: Icon(
                              Icons.key,
                              color: Colors.white60,
                            ))),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                      onPressed: signInNoGoogle,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white70,
                      ),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(color: Colors.black),
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  GoogleSign(callBack: () => setState(() {}))
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  void signInNoGoogle() {
    Navigator.pushNamed(context, '/main');
  }
}

class GoogleSign extends StatefulWidget {
  final Function callBack;

  const GoogleSign({Key? key, required this.callBack}) : super(key: key);

  @override
  State<GoogleSign> createState() => GoogleSignState();
}

class GoogleSignState extends State<GoogleSign> {
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
    var screenWidth = (MediaQuery.of(context).size.width);
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
                        fontSize: 15))
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
              'Sign out',
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
                  style: TextStyle(color: Colors.black)))
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
