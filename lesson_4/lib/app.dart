import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login_page/login_page.dart';
import 'main_page/main_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {'/login' :(context)=>const LoginPage(),
      '/main' :(context)=>MainPage()},
        initialRoute: '/login',
    );
  }
}