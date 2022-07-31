import 'package:assignment_5/pages/login_page/widgets/sign_in_button_widget.dart';
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
    Object? checkLogOut = ModalRoute
        .of(context)
        ?.settings
        .arguments;
    if (checkLogOut != null) {
      logOut();
      checkLogOut = null;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = (MediaQuery
        .of(context)
        .size
        .height);
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(title: const Text('Authorization')),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: screenHeight / 4.5),
                const Text("Login",
                    style: TextStyle(fontSize: 25, color: Colors.black)),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(hintText: 'email'),
                ),
                const SizedBox(height: 16),
                TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(hintText: 'password')),
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
                        child: const Text('Sign Up')),
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

