import 'package:flutter/material.dart';
import 'package:flutter_animations/pages/main_page/main_page.dart';
import 'package:flutter_animations/pages/second_page/second_page.dart';
import 'package:flutter_animations/pages/third_page/third_page.dart';


class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {'/main' :(context)=> MainPage(),
      '/second': (context) =>SecondPage(),
      '/third' : (context) => ThirdPage()},
      initialRoute: '/main',
    );
  }
}