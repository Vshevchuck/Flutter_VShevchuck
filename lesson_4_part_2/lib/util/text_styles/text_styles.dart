import 'package:flutter/material.dart';

import '../../pages/main_page/main_page.dart';

abstract class TextStyles {
  static TextStyle cityFindTextStyle =
      TextStyle(color: MainPageState.nightTheme ? Colors.white : Colors.black, fontWeight: FontWeight.w300);
}
