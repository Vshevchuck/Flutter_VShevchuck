import 'package:flutter/material.dart';

import '../../../domains/weather_model/weather_data_model.dart';
import '../../../util/colors/colors_style.dart';
import 'change_hours_or_days_widget.dart';
import 'days_weather_widget.dart';
import 'hours_weather_widget.dart';

class TemperatureScale extends StatelessWidget {
  final WeatherData weatherData;
  const TemperatureScale({Key? key,required this.weatherData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 130,
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(width: 2.5, color: ColorStyle.borderSideColor),
              ),
              color: ColorStyle.bottomContainerColor,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top : 8.0),
              child: Center(
                child: ChangeHoursOrDaysWidgetState.selectedItem == "By the hour"
                    ? HoursWeatherWidget(weather: weatherData)
                    : DaysWeatherWidget(weather: weatherData),
              ),
            ),
          ),
      ),
    );
  }
}



