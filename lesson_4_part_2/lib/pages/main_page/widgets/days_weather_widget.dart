import 'package:flutter/material.dart';
import 'package:weather_app/domains/weather_model/weather_data_model.dart';

import 'model_day_weather_widget.dart';

class DaysWeatherWidget extends StatelessWidget {
  final WeatherData weather;
  static const hourPeriod=8;

  const DaysWeatherWidget({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return index == 0
              ? ModelWeatherDayWidget(weather: weather, index: (index))
              : ModelWeatherDayWidget(weather: weather, index: (index) * hourPeriod);
        });
  }
}
