import 'package:flutter/material.dart';
import 'package:weather_app/pages/main_page/main_page.dart';


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