import 'package:flutter/material.dart';

import '../../utils/text_styles/Texts_styles.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [Text(
        'Welocme Back!',
        style: TextsStyles.welcomeTextStyle,
      ),
        SizedBox(height: 8),
        Text(
          "Sign in to your profile",
          style: TextsStyles.signInTestStyle,
        ),
        SizedBox(height: 32.0),]
    );
  }
}
