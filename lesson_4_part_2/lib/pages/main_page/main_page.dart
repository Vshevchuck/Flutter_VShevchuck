import 'package:flutter/material.dart';
import 'package:weather_app/util/images/images_data.dart';

import '../../domains/api_clients/api_client.dart';
import '../../domains/weather_model/weather_data_model.dart';
import '../../util/text_styles/text_styles.dart';
import '../../weather_data/weather_data.dart';
import '../../weather_data/weather_data.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final model = WeatherModel();
    final apiClient = ApiClient();
    //final weather=WeatherModelProvider
    //.read(context)!
        //.model;
    Map<String, dynamic> data;
    Map<String, dynamic> show (Map<String, dynamic> weather)
    {
      print("- $weather");
      return weather;
    }
     Future<Map<String, dynamic>> reloadPost() async {
      final weather = await apiClient.getWeather();
      show(weather);
      return weather;
      //print('+ $weather');
    }



     print('+ ${reloadPost()}');
    return Scaffold(
      body: WeatherModelProvider(
        model: model,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: BackgroundImage.backgroundMorningImage,
                fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: TextField(
                    style: TextStyles.cityFindTextStyle,
                    decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.white70),
                        hintText: 'city',
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(width: 2.0, color: Colors.white)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(width: 1.0, color: Colors.white60)),
                        isCollapsed: true,
                        contentPadding: EdgeInsets.only(top: 16.0),
                        prefixIcon: Icon(
                          Icons.location_city,
                          color: Colors.white60,
                        ))),
              ),
              Center(child: Text('')),
            ],
          ),
        ),
      ),
    );
  }
}
