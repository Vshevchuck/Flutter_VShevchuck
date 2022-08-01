import 'package:assignment_5/generated/locale_keys.g.dart';
import 'package:assignment_5/pages/login_page/widgets/sign_in_button_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/login_bloc/login_bloc.dart';

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
  initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Object? checkLogOut = ModalRoute.of(context)?.settings.arguments;
    if (checkLogOut != null) {
      logOut();
      checkLogOut = null;
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
                onPressed: () {
                  if (context.locale == Locale('en')) {
                    try{
                      context.setLocale(const Locale.fromSubtags(languageCode:'ru'));
                     // context.setLocale(Locale('ua'));
                    }catch(e){
                      print(e);
                    }
                  }
                  else if (context.locale == const Locale.fromSubtags(languageCode:'ru')) {
                    context.setLocale(Locale('en'));
                  }
                },
                icon: const Icon(Icons.language),
              ),
              title: Text(LocaleKeys.Authorization.tr())),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: screenHeight / 4.5),
                Text(LocaleKeys.Login.tr(),
                    style: TextStyle(fontSize: 25, color: Colors.black)),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(hintText: LocaleKeys.Email.tr()),
                ),
                const SizedBox(height: 16),
                TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(hintText: LocaleKeys.Password.tr())),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SignInButtonWidget(),
                    ElevatedButton(
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
    );
  }

  void logOut() async {
    await FirebaseAuth.instance.signOut();
    setState(() {});
  }
}
