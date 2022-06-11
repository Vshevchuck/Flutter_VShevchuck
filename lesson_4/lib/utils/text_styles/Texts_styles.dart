import 'package:flutter/material.dart';

abstract class TextsStyles {
  static const welcomeTextStyle =
      TextStyle(fontSize: 35, color: Colors.black, fontWeight: FontWeight.w500);
  static const signInTestStyle =
      TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w200);
  static const displayNameTextStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18);
  static const emailTextStyle = TextStyle(
      color: Colors.white70, fontWeight: FontWeight.w500, fontSize: 15);
  static const signSuccessfullyTextStyle =
      TextStyle(color: Colors.white, fontSize: 16);
  static const notSignedTextStyle =
      TextStyle(color: Colors.white, fontSize: 16);
  static const loginTextStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.w300);
  static const titleTextStyle = TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w500);
}
