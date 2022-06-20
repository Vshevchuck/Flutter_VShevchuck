import 'package:flutter/material.dart';
import 'package:weather_app/domains/weather_model/weather_data_model.dart';

import 'model_hour_weather_widget.dart';

class ModelWeatherDayWidget extends StatelessWidget {
  final WeatherData weather;
  final int index;

  const ModelWeatherDayWidget(
      {Key? key, required this.weather, required this.index})
      : super(key: key);

  Widget toDay() {
    if (index == 0) {
      return const Text("Now", style: TextStyle(color: Colors.white, fontSize: 15));
    }
    return const SizedBox(height: 18);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          const SizedBox(height: 4.0),
          toDay(),
          Text(
            getOnlyDate(weather.list![index].dtTxt.toString()),
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          Image.network(
              'http://openweathermap.org/img/wn/${weather.list![index].weather![0].icon}.png'),
          Text(
            '${(weather.list![index].main?.temp?.toInt()).toString()}° / '
            '${(ModelWeatherHourWidget.setTemperatureFromCelsiusToFahrenheit
              (weather.list![index].main?.temp?.toInt())).toString()}F°',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          )
        ],
      ),
    );
  }

  getOnlyDate(String string) {
    string = string.split(' ')[0];
    return '${string.split('-')[1]} . ${string.split('-')[2]}';
  }
}
