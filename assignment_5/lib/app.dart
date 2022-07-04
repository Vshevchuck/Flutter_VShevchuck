import 'package:assignment_5/pages/main_page/main_page.dart';
import 'package:flutter/material.dart';


class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {'/main' :(context)=> MainPage()},
      initialRoute: '/main',
    );
  }
}