import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/login_block.dart';
import '../../bloc/login_state.dart';
import '../../models/user_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
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
    User? user = FirebaseAuth.instance.currentUser;
    return BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(),
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
                title: Text(
                    'Auth User (Logged ${user == null ? 'out' : '${user
                        .email}'})')),
            body: Column(
              children: [
                TextField(controller: emailController),
                TextField(controller: passwordController),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SignInButton(),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed(
                              '/register');
                          setState(() {});
                        },
                        child: const Text('Sign Up')),
                    ElevatedButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          setState(() {});
                        },
                        child: const Text('Sign Out')),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('get id'),
                    ),
                  ],
                )
              ],
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

class SignInButton extends StatelessWidget {
  const SignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);
    return BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is UserLoginedState) {
            Future.delayed(Duration.zero, () {
              Navigator.of(context)
                  .pushReplacementNamed('/main', arguments: state.user);
            });
          }
          return ElevatedButton(
            onPressed: () async {
              UserLogin userModel = UserLogin(
                  LoginPageState.emailController.text,
                  LoginPageState.passwordController.text);
              loginBloc.add(userModel);
            },
            child: const Text('Sign In'),
          );
        }
    );
  }
}
