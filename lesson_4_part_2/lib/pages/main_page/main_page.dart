import 'package:flutter/material.dart';
import 'package:weather_app/pages/main_page/widgets/change_hours_or_days_widget.dart';
import 'package:weather_app/pages/main_page/widgets/model_hour_weather_widget.dart';
import 'package:weather_app/pages/main_page/widgets/temperature_scale.dart';
import 'package:weather_app/pages/main_page/widgets/weather_city_now.dart';
import 'package:weather_app/util/images/images_data.dart';

import '../../domains/api_clients/api_client.dart';
import '../../domains/weather_model/weather_data_model.dart';
import '../../util/text_field_decoration/text_field_decoration.dart';
import '../../util/text_styles/text_styles.dart';

WeatherData? weather;

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  static bool nightTheme = true;
  static String city = "Kropyvnytskyi";
  ApiClient apiClient = ApiClient(city);

  @override
  initState() {
    super.initState();
    reloadWeather();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: weather != null
            ? DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: setBackground(), fit: BoxFit.cover),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                          onSubmitted: (text) {
                            if (text != "") {
                              apiClient = ApiClient(text);
                              city = text;
                              reloadWeather();
                            }
                          },
                          style: TextStyles.cityFindTextStyle,
                          decoration: TextFiledDecoration.textFieldDecoration),
                    ),
                    WeatherInfoNow(city: city),
                    const Spacer(flex: 2),
                    ChangeHoursOrDaysWidget(
                        setStateMainScreen: () => setState(() {})),
                    TemperatureScale(
                      weatherData: weather!,
                    ),
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  AssetImage setBackground() {
    if (ModelWeatherHourWidget.getOnlyHour(
                weather!.list!.first.dtTxt.toString()) ==
            "00:00:00" ||
        ModelWeatherHourWidget.getOnlyHour(
                weather!.list!.first.dtTxt.toString()) ==
            "03:00:00") {
      return BackgroundImage.backgroundNightImage;
    }
    if (ModelWeatherHourWidget.getOnlyHour(
                weather!.list!.first.dtTxt.toString()) ==
            "06:00:00" ||
        ModelWeatherHourWidget.getOnlyHour(
                weather!.list!.first.dtTxt.toString()) ==
            "09:00:00") {
      return BackgroundImage.backgroundMorningImage;
    }
    if (ModelWeatherHourWidget.getOnlyHour(
                weather!.list!.first.dtTxt.toString()) ==
            "18:00:00" ||
        ModelWeatherHourWidget.getOnlyHour(
                weather!.list!.first.dtTxt.toString()) ==
            "21:00:00") {
      return BackgroundImage.backgroundEveningImage;
    }
    nightTheme = false;
    return BackgroundImage.backgroundDayImage;
  }

  Future<void> reloadWeather() async {
    var weatherAsync = await apiClient.getWeather();
    if (weatherAsync.message != null &&
        weatherAsync.message == "city not found") {
      apiClient = ApiClient(city = "London");
      weatherAsync = await apiClient.getWeather();
    }
    setState(() => weather = weatherAsync);
  }
}
