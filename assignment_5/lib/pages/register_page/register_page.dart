import 'package:assignment_5/bloc/register_bloc/register_bloc.dart';
import 'package:assignment_5/pages/register_page/widgets/button_register_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../generated/locale_keys.g.dart';
import '../../util/text_styles/text_styles.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  static final emailController = TextEditingController();
  static final passwordController = TextEditingController();
  static final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenHeight = (MediaQuery.of(context).size.height);
    return BlocProvider<RegisterBloc>(
      create: (context) => RegisterBloc(),
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.Authorization.tr()),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: screenHeight / 5.0),
                Text(LocaleKeys.Register.tr(),
                    style: TextStyles.registerTextStyle),
                TextField(
                    controller: nameController,
                    decoration: InputDecoration(hintText: LocaleKeys.Name.tr())),
                TextField(
                    controller: emailController,
                    decoration: InputDecoration(hintText: LocaleKeys.Email.tr())),
                TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration:
                        InputDecoration(hintText: LocaleKeys.Password.tr())),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const ButtonRegisterWidget(),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed('/login', arguments: null);
                        },
                        child: Text(LocaleKeys.Go_Back.tr()))
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
