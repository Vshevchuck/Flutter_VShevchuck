import 'package:assignment_5/bloc/register_bloc.dart';
import 'package:assignment_5/bloc/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/user_model.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
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
                  controller: passwordController,
                  decoration: const InputDecoration(hintText: 'password')),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Button(
                      email: emailController.text,
                      password: passwordController.text,
                      name: nameController.text),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed('/login', arguments: null);
                      },
                      child: Text('Go back'))
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}

class Button extends StatelessWidget {
  final String email;
  final String password;
  final String name;

  const Button({
    Key? key,
    required this.email,
    required this.password,
    required this.name,
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
        return ElevatedButton(
            onPressed: () {
              UserRegister userModel = UserRegister(
                  RegisterPageState.nameController.text,
                  RegisterPageState.emailController.text,
                  RegisterPageState.passwordController.text);
              registerBloc.add(userModel);
              RegisterPageState.emailController.text = "";
              RegisterPageState.passwordController.text = "";
              RegisterPageState.nameController.text = "";
            },
            child: Text('Register'));
      },
    );
  }
}
