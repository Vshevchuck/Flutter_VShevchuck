import 'package:flutter/material.dart';

import '../../../domains/weather_model/weather_data_model.dart';
import 'change_hours_or_days_widget.dart';
import 'days_weather_widget.dart';
import 'hours_weather_widget.dart';

class TemperatureScale extends StatelessWidget {
  final WeatherData weatherData;
  const TemperatureScale({Key? key,required this.weatherData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(width: 2.5, color: Colors.white),
          ),
          color: Colors.black54,
        ),
        child: Center(
          child: ChangeHoursOrDaysWidgetState.selectedItem == "By the hour"
              ? HoursWeatherWidget(weather: weatherData)
              : DaysWeatherWidget(weather: weatherData),
        ),
      ),
    );
  }
}



