import 'package:flutter/material.dart';

import '../../pages/main_page/main_page.dart';

abstract class TextStyles {
  static TextStyle cityFindTextStyle =
      TextStyle(color: MainPageState.nightTheme ? Colors.white : Colors.black, fontWeight: FontWeight.w300);
  static const dropdownButtonTitleTextStyle =  TextStyle(fontSize: 17, color: Colors.white);
  static const dropdownButtonElementTextStyle  = TextStyle(
      fontSize: 17, color: Colors.white);
  static const nowTextStyle = TextStyle(color: Colors.white, fontSize: 15);
  static const dayTextStyle = TextStyle(color: Colors.white, fontSize: 16);
  static const temperatureTextStyle = TextStyle(color: Colors.white, fontSize: 16);
  static const hourTextStyle = TextStyle(color: Colors.white, fontSize: 16);
  static TextStyle cityTextStyle = TextStyle(
      color: MainPageState.nightTheme
          ? Colors.white70
          : Colors.black87,
      fontSize: 35,
      fontWeight: FontWeight.w300);
  static TextStyle mainTemperatureTextStyle = TextStyle(
      color: MainPageState.nightTheme
          ? Colors.white70
          : Colors.black87,
      fontSize: 70,
      fontWeight: FontWeight.w300);
  static TextStyle descriptionTextStyle = TextStyle(
      color: MainPageState.nightTheme
          ? Colors.white70
          : Colors.black87,
      fontSize: 20,
      fontWeight: FontWeight.w300);
}
