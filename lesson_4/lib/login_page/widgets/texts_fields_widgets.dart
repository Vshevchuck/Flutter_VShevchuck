import 'package:flutter/material.dart';
import 'package:whe/utils/text_styles/Texts_styles.dart';

class TextFieldsWidget extends StatelessWidget {
  const TextFieldsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: const [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.0),
        child: TextField(
            style: TextsStyles.loginTextStyle,
            decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.white70),
                hintText: 'Username',
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(width: 2.0, color: Colors.white)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(width: 1.0, color: Colors.white60)),
                isCollapsed: true,
                contentPadding: EdgeInsets.only(top: 16.0),
                prefixIcon: Icon(
                  Icons.account_circle_rounded,
                  color: Colors.white60,
                ))),
      ),
      SizedBox(height: 16.0),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.0),
        child: TextField(
            style: TextsStyles.loginTextStyle,
            obscureText: true,
            decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.white70),
                hintText: 'password',
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(width: 2.0, color: Colors.white)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(width: 1.0, color: Colors.white60)),
                isCollapsed: true,
                contentPadding: EdgeInsets.only(top: 16.0),
                prefixIcon: Icon(
                  Icons.key,
                  color: Colors.white60,
                ))),
      ),
      SizedBox(
        height: 20,
      ),
    ]);
  }
}
