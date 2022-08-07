import 'package:assignment_5/generated/locale_keys.g.dart';
import 'package:assignment_5/pages/login_page/widgets/sign_in_button_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/login_bloc/login_bloc.dart';
import '../../util/text_styles/text_styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  static String message = '';
  static final emailController = TextEditingController();
  static final passwordController = TextEditingController();

  @override
  void didChangeDependencies() {
    if (FirebaseAuth.instance.currentUser != null) {
      Future.delayed(Duration.zero, () {
        Navigator.of(context).pushReplacementNamed('/main',
            arguments: FirebaseAuth.instance.currentUser);
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = (MediaQuery.of(context).size.height);
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
              leading: IconButton(
                onPressed: changeLanguage,
                icon: const Icon(Icons.language),
              ),
              title: Text(LocaleKeys.Authorization.tr())),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(height: 16,),
                      const SignInButtonWidget(),
                      const SizedBox(height: 16,),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed('/register');
                            setState(() {});
                          },
                          child: Text(LocaleKeys.Sign_Up.tr())),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void changeLanguage() {
    if (context.locale == const Locale('en')) {
      context.setLocale(const Locale.fromSubtags(languageCode: 'ru'));
    } else if (context.locale == const Locale('ru')) {
      context.setLocale(const Locale('en'));
    }
  }
}
