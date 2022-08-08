import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../generated/locale_keys.g.dart';

class TextFieldsWidget extends StatelessWidget {
  final nameController;
  final emailController;
  final passwordController;

  const TextFieldsWidget(
      {Key? key,
      required this.nameController,
      required this.emailController,
      required this.passwordController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 26),
        TextField(
            controller: nameController,
            decoration: InputDecoration(
                hintText: LocaleKeys.Name.tr(),
                suffixIcon: const Icon(Icons.account_circle_rounded))),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                  hintText: LocaleKeys.Email.tr(),
                  suffixIcon: const Icon(Icons.alternate_email))),
        ),
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
