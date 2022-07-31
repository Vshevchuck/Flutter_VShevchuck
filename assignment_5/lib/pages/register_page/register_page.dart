import 'package:assignment_5/bloc/register_bloc/register_bloc.dart';
import 'package:assignment_5/pages/register_page/widgets/button_register_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


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
                  const ButtonRegisterWidget(),
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
