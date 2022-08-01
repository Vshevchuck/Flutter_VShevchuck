import 'package:assignment_5/pages/chat_room/chat_room_page.dart';
import 'package:assignment_5/pages/login_page/login_page.dart';
import 'package:assignment_5/pages/main_page/main_page.dart';
import 'package:assignment_5/pages/register_page/register_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';


class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routes: {'/main' :(context,{arguments})=>const MainPage(),
      '/register' : (context) => const RegisterPage(),
      '/login' : (context,{arguments}) => const LoginPage(),
      '/chatroom':(context,{arguments}) =>const ChatRoomPage()},
      initialRoute: '/login',
    );
  }
}