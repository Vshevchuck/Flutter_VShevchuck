import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/login_bloc.dart';
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
    Object? checkLogOut = ModalRoute.of(context)?.settings.arguments;
    if (checkLogOut != null) {
      logOut();
      checkLogOut = null;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(title: const Text('Authorization')),
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
                        Navigator.of(context).pushReplacementNamed('/register');
                        setState(() {});
                      },
                      child: const Text('Sign Up')),
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
          UserLogin userModel = UserLogin(LoginPageState.emailController.text,
              LoginPageState.passwordController.text);
          loginBloc.add(userModel);
          LoginPageState.emailController.text="";
          LoginPageState.passwordController.text="";
        },
        child: const Text('Sign In'),
      );
    });
  }
}
