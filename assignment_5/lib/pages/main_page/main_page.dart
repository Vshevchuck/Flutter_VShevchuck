import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {
    final dataUser = (ModalRoute.of(context)?.settings.arguments) as User;

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
                title: Row(
                  children: [Text('${dataUser.email}'), ElevatedButton(onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login',arguments: true);
                  }, child: Text('Log out'))
                  ],
                )),
            body: Center(child: Text('Text'))));
  }
}
