import 'package:flutter/material.dart';
import 'package:whe/login_page/widgets/go_to_notes_widget.dart';
import 'package:whe/login_page/widgets/google_sign_widget.dart';
import 'package:whe/login_page/widgets/header_widget.dart';
import 'package:whe/login_page/widgets/texts_fields_widgets.dart';
import 'package:whe/utils/text_styles/Texts_styles.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
        child: SizedBox(
          height: screenHeight,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: screenHeight / 1.2,
              child: Column(
                children: [
                  const HeaderWidget(),
                  TextFieldsWidget(),
                  GoogleSign(callBack: () => setState(() {})),
                  const SizedBox(
                    height: 17,
                  ),
                  GoToNotes(),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
