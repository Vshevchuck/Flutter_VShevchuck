import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../generated/locale_keys.g.dart';
import '../../../util/text_styles/text_styles.dart';

class TextFieldsWidget extends StatelessWidget {
  final double screenHeight;
  final emailController;
  final passwordController;

  const TextFieldsWidget(
      {Key? key,
      required this.screenHeight,
      required this.emailController,
      required this.passwordController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: screenHeight / 5.3),
        Text(LocaleKeys.Login.tr(), style: TextStyles.loginTextStyle),
        const SizedBox(height: 26),
        TextField(
          controller: emailController,
          decoration: InputDecoration(
              hintText: LocaleKeys.Email.tr(),
              suffixIcon: const Icon(Icons.alternate_email)),
        ),
        const SizedBox(height: 20),
        TextField(
            obscureText: true,
            controller: passwordController,
            decoration: InputDecoration(
                hintText: LocaleKeys.Password.tr(),
                suffixIcon: const Icon(Icons.password))),
        const SizedBox(height: 8.0),
      ],
    );
  }
}
