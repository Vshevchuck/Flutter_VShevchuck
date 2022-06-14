import 'package:flutter/material.dart';

import '../domains/api_clients/api_client.dart';

class WeatherModel extends ChangeNotifier {
  static final apiClient = ApiClient();

  static List<Map<String, dynamic>> weatherData = <Map<String, dynamic>>[];

  Future<void> reloadPost() async {
    final weather = await apiClient.getWeather();
    print('+ $weather');
    weatherData.add(weather);
    notifyListeners();
  }

  List<Map<String, dynamic>> get data => weatherData;
}

class WeatherModelProvider extends InheritedNotifier {
  final WeatherModel model;

  const WeatherModelProvider(
      {Key? key, required this.model, required Widget child})
      : super(key: key, notifier: model, child: child);

  static WeatherModelProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<WeatherModelProvider>();
  }

  static WeatherModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<WeatherModelProvider>()
        ?.widget;
    return widget is WeatherModelProvider ? widget : null;
  }
}
