import 'dart:convert';
import 'dart:io';

import 'package:weather_app/domains/weather_model/weather_model.dart';

import '../weather_model/weather_data_model.dart';

class ApiClient {
  final client = HttpClient();

  Future<Autogenerated> getWeather() async {
    final json = await get();
    return json;
  }

  Future<dynamic> get() async {
    String city = "kropyvnytskyi";
    final queryParameters = {
      'q': city,
      'appid': '7972250db8a62ce7a6a179038632b2c5',
      'units' : 'metric'
    };
    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/forecast', queryParameters);
    final request = await client.getUrl(uri);
    final response = await request.close();

    final jsonStrings = await response.transform(utf8.decoder).toList();
    print(jsonStrings);
    //print('----------------------------------');
    final jsonString = jsonStrings.join();
    final dynamic json = jsonDecode(jsonString);
    return Autogenerated.fromJson(json);
  }
}
