import 'package:flutter/material.dart';

import '../main_page.dart';

class WeatherInfoNow extends StatelessWidget {
  final String city;
  const WeatherInfoNow({Key? key, required this.city}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(city,
            style: TextStyle(
                color: MainPageState.nightTheme
                    ? Colors.white70
                    : Colors.black87,
                fontSize: 35,
                fontWeight: FontWeight.w300)),
        Text(
            ' ${(weather?.list![0].main?.temp?.toInt()).toString()}°',
            style: TextStyle(
                color: MainPageState.nightTheme
                    ? Colors.white70
                    : Colors.black87,
                fontSize: 70,
                fontWeight: FontWeight.w300)),
        Text((weather?.list![0].weather![0].description).toString(),
            style: TextStyle(
                color: MainPageState.nightTheme
                    ? Colors.white70
                    : Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.w300)),
      ],
    );
  }
}

