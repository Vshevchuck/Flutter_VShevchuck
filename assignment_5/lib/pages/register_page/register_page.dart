import 'package:assignment_5/bloc/register_bloc.dart';
import 'package:assignment_5/bloc/register_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/register_event.dart';
import '../../models/user_model.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterBloc>(
      create: (context) => RegisterBloc(),
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          title: Text('Register'),
        ),
        body: Column(
          children: [
            TextField(controller: nameController),
            TextField(controller: emailController),
            TextField(controller: passwordController),
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
      )),
    );
  }
}

class Button extends StatelessWidget {
  final String email;
  final String password;
  final String name;

  const Button(
      {Key? key,
      required this.email,
      required this.password,
      required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserRegister userModel = UserRegister(
        name, email, password);
    final RegisterBloc registerBloc = BlocProvider.of<RegisterBloc>(context);
    return ElevatedButton(
        onPressed: () {
          registerBloc.add(userModel);
          //await FirebaseAuth.instance
          //.createUserWithEmailAndPassword(
          //email: emailController.text,
          //password: passwordController.text);
          //user = FirebaseAuth.instance.currentUser;
          BlocBuilder<RegisterBloc, RegisterState>(
            builder: (context, state) {
              if (state is UserRegisteredState) {
                Navigator.of(context)
                    .pushReplacementNamed('/main', arguments: state.user);
              }
              return Text("smth is wrong");
            },
          );
        },
        child: Text('Register'));
  }
}
