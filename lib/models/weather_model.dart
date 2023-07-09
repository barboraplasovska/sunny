import 'package:sunny/models/condition_model.dart';
import 'package:sunny/models/forecast_model.dart';
import 'package:sunny/models/location_model.dart';

class WeatherModel {
  final ConditionModel condition;
  final LocationModel location;
  final List<ForecastModel> forecast;
  final int lastUpdatedEpoch;
  final String lastUpdated;
  final int tempC;
  final int tempF;
  final int isDay;
  final double windMph;
  final double windKph;
  final int windDegree;
  final String windDir;
  final double pressureMb;
  final double pressureIn;
  final double precipMm;
  final double precipIn;
  final int humidity;
  final int cloud;
  final int feelslikeC;
  final double feelslikeF;
  final int visKm;
  final double visMiles;
  final double uv;
  final double gustMph;
  final double gustKph;

  WeatherModel({
    required this.condition,
    required this.location,
    required this.forecast,
    required this.lastUpdatedEpoch,
    required this.lastUpdated,
    required this.tempC,
    required this.tempF,
    required this.isDay,
    required this.windMph,
    required this.windKph,
    required this.windDegree,
    required this.windDir,
    required this.pressureMb,
    required this.pressureIn,
    required this.precipMm,
    required this.precipIn,
    required this.humidity,
    required this.cloud,
    required this.feelslikeC,
    required this.feelslikeF,
    required this.visKm,
    required this.visMiles,
    required this.uv,
    required this.gustMph,
    required this.gustKph,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    var forecastList = (json['forecast']['forecastday'] as List<dynamic>)
        .map((forecastJson) => ForecastModel.fromJson(forecastJson))
        .toList();

    var current = json['current'];
    return WeatherModel(
      condition: ConditionModel.fromJson(current['condition']),
      location: LocationModel.fromJson(json['location']),
      forecast: forecastList,
      lastUpdatedEpoch: current['last_updated_epoch'],
      lastUpdated: current['last_updated'],
      tempC: current['temp_c'].round(),
      tempF: current['temp_f'].round(),
      isDay: current['is_day'],
      windMph: current['wind_mph'],
      windKph: current['wind_kph'],
      windDegree: current['wind_degree'],
      windDir: current['wind_dir'],
      pressureMb: current['pressure_mb'],
      pressureIn: current['pressure_in'],
      precipMm: current['precip_mm'],
      precipIn: current['precip_in'],
      humidity: current['humidity'],
      cloud: current['cloud'],
      feelslikeC: current['feelslike_c'].round(),
      feelslikeF: current['feelslike_f'],
      visKm: current['vis_km'].round(),
      visMiles: current['vis_miles'],
      uv: current['uv'],
      gustMph: current['gust_mph'],
      gustKph: current['gust_kph'],
    );
  }
}
