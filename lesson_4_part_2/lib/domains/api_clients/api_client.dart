import 'dart:convert';
import 'dart:io';

import '../weather_model/weather_data_model.dart';

class ApiClient {
  final client = HttpClient();

  Future<Map<String, dynamic>> getWeather() async {
    final json = await get() as Map<String,dynamic>;
    return json;
  }

  Future<dynamic> get() async {
    String city = "London";
    final queryParameters = {
      'q': city,
      'appid': '7972250db8a62ce7a6a179038632b2c5',
    };
    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/forecast', queryParameters);
    final request = await client.getUrl(uri);
    final response = await request.close();

    final jsonStrings = await response.transform(utf8.decoder).toList();
    print(jsonStrings);
    print('----------------------------------');
    final jsonString = jsonStrings.join();
    final dynamic json = jsonDecode(jsonString);
    print(json);
    return json;
  }
}
