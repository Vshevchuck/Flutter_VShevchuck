import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/login_bloc.dart';
import '../../../bloc/login_state.dart';
import '../../../models/user_model.dart';
import '../login_page.dart';

class SignInButtonWidget extends StatelessWidget {
  const SignInButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);
    BlocProvider
        .of<LoginBloc>(context)
        .initialState;
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      if (state is UserLoginedState) {
        Future.delayed(Duration.zero, () {
          Navigator.of(context)
              .pushReplacementNamed('/main', arguments: state.user);
        });
      }
      if (state is LoginErrorState) {
        loginBloc.add('initial');
        LoginPageState.message = state.message;
        scheduleMicrotask(
                () => Navigator.of(context).restorablePush(_dialogBuilder));
      }
      return Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              UserLogin userModel = UserLogin(
                  LoginPageState.emailController.text,
                  LoginPageState.passwordController.text);
              loginBloc.add(userModel);
              LoginPageState.emailController.text = "";
              LoginPageState.passwordController.text = "";
            },
            child: const Text('Sign In'),
          ),
        ],
      );
    });
  }

  static Route<Object?> _dialogBuilder(BuildContext context,
      Object? arguments) {
    return DialogRoute<void>(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(
            title: Text(LoginPageState.message),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('ok'))
            ],
          ),
    );
  }
}
