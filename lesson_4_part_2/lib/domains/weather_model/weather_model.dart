
class WeatherResponse{
  final String cityName;
  WeatherResponse({required this.cityName});  //!!! change city

  factory WeatherResponse.fromJson(Map<String,dynamic> json)
  {
      final cityName = json['name'];
      return WeatherResponse(cityName: cityName);
  }
}