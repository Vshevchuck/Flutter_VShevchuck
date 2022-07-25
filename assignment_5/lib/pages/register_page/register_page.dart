import 'dart:async';

import 'package:assignment_5/bloc/register_bloc.dart';
import 'package:assignment_5/bloc/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/user_model.dart';
import '../login_page/login_page.dart';

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
          title: const Text('Authorization'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: screenHeight / 5.0),
              const Text("Register",
                  style: TextStyle(fontSize: 25, color: Colors.black)),
              TextField(
                  controller: nameController,
                  decoration: const InputDecoration(hintText: 'name')),
              TextField(
                  controller: emailController,
                  decoration: const InputDecoration(hintText: 'email')),
              TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(hintText: 'password')),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const ButtonWidget(),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed('/login', arguments: null);
                      },
                      child: const Text('Go back'))
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
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
