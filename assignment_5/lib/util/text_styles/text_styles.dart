import 'package:flutter/material.dart';

abstract class TextStyles {
  static const loginTextStyle = TextStyle(fontSize: 25, color: Colors.black);
  static const firstLetterOfNameTextStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18);
  static const nameTextStyle = TextStyle(fontWeight: FontWeight.w500);
  static const emailTextStyle = TextStyle(fontStyle: FontStyle.italic);
  static const lastMessageTextStyle = TextStyle(fontStyle: FontStyle.italic);
  static const messageStartDialogTextStyle =
      TextStyle(fontSize: 18, color: Colors.black54);
  static const messageTextStyle=TextStyle(
      color: Colors.white,
      fontSize: 15);
  static const registerTextStyle = TextStyle(fontSize: 25, color: Colors.black);
}
