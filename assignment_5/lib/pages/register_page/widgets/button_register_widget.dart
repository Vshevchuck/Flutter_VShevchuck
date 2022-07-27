import 'dart:async';

import 'package:assignment_5/pages/register_page/register_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/register_bloc.dart';
import '../../../bloc/register_state.dart';
import '../../../models/user_model.dart';
import '../../login_page/login_page.dart';

class ButtonRegisterWidget extends StatelessWidget {
  const ButtonRegisterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RegisterBloc registerBloc = BlocProvider.of<RegisterBloc>(context);

    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        if (state is UserRegisteredState) {
          Future.delayed(Duration.zero, () {
            Navigator.of(context)
                .pushReplacementNamed('/main', arguments: state.user);
          });
        }
        if (state is RegisterErrorState) {
          registerBloc.add('initial');
          LoginPageState.message = state.message;
          scheduleMicrotask(
                  () => {Navigator.of(context).restorablePush(_dialogBuilder)});
        }
        return ElevatedButton(
            onPressed: () {
              UserRegister userModel = UserRegister(
                  RegisterPage.nameController.text,
                  RegisterPage.emailController.text,
                  RegisterPage.passwordController.text);
              registerBloc.add(userModel);
              RegisterPage.emailController.text = "";
              RegisterPage.passwordController.text = "";
              RegisterPage.nameController.text = "";
            },
            child: const Text('Register'));
      },
    );
  }

  static Route<Object?> _dialogBuilder(
      BuildContext context, Object? arguments) {
    return DialogRoute<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(LoginPageState.message),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('ok'))
        ],
      ),
    );
  }
}
