import 'package:flutter/material.dart';

import '../../../util/text_styles/text_styles.dart';
import '../main_page.dart';

class WeatherInfoNow extends StatelessWidget {
  final String city;
  const WeatherInfoNow({Key? key, required this.city}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(city,
            style: TextStyles.cityTextStyle),
        Text(
            ' ${(weather?.list![0].main?.temp?.toInt()).toString()}°',
            style: TextStyles.mainTemperatureTextStyle),
        Text((weather?.list![0].weather![0].description).toString(),
            style: TextStyles.descriptionTextStyle),
      ],
    );
  }
}

