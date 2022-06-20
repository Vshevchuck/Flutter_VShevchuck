import 'package:flutter/material.dart';
import 'package:weather_app/pages/main_page/main_page.dart';

abstract class TextFiledDecoration {
  static InputDecoration textFieldDecoration = InputDecoration(
      hintStyle: TextStyle(
          color:
          MainPageState.nightTheme ? Colors.white70 : Colors.black87),
      hintText: 'city',
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              width: 2.0,
              color: MainPageState.nightTheme
                  ? Colors.white
                  : Colors.black87)),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              width: 1.0,
              color: MainPageState.nightTheme
                  ? Colors.white60
                  : Colors.black87)),
      isCollapsed: true,
      contentPadding: const EdgeInsets.only(top: 16.0),
      prefixIcon: Icon(
        Icons.location_city,
        color: MainPageState.nightTheme ? Colors.white70 : Colors.black87,
      ));
}