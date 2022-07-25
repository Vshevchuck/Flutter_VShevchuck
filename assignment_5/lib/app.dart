import 'package:assignment_5/pages/chat_room/chat_room.dart';
import 'package:assignment_5/pages/login_page/login_page.dart';
import 'package:assignment_5/pages/main_page/main_page.dart';
import 'package:assignment_5/pages/register_page/register_page.dart';
import 'package:flutter/material.dart';


class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {'/main' :(context,{arguments})=>const MainPage(),
      '/register' : (context) => const RegisterPage(),
      '/login' : (context,{arguments}) => const LoginPage(),
      '/chatroom':(context,{arguments}) =>const ChatRoom()},
      initialRoute: '/login',
    );
  }
}