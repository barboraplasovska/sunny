import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sunny/models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherService {
  final String _apiKey;

  WeatherService() : _apiKey = dotenv.env['API_KEY'] ?? '';

  Future<WeatherModel> fetchWeatherData(String city, {int nbDays = 10}) async {
    final String apiUrl =
        'http://api.weatherapi.com/v1/forecast.json?key=$_apiKey&q=$city&days=$nbDays&aqi=no&alerts=no';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return WeatherModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }
}

int getHour(String timeString) {
  DateTime dateTime = DateTime.parse(timeString);
  return dateTime.hour;
}

int getCurrentHour() {
  DateTime currentTime = DateTime.now();
  return currentTime.hour;
}
