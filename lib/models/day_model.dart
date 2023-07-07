import 'package:sunny/models/condition_model.dart';

class DayModel {
  final int maxTempC;
  final int maxTempF;
  final int minTempC;
  final int minTempF;
  final int avgTempC;
  final int avgTempF;
  final double maxWindMph;
  final double maxWindKph;
  final double totalPrecipMm;
  final double totalPrecipIn;
  final double totalSnowCm;
  final double avgVisKm;
  final double avgVisMiles;
  final double avgHumidity;
  final int dailyWillItRain;
  final int dailyChanceOfRain;
  final int dailyWillItSnow;
  final int dailyChanceOfSnow;
  final ConditionModel condition;
  final double uv;

  DayModel({
    required this.maxTempC,
    required this.maxTempF,
    required this.minTempC,
    required this.minTempF,
    required this.avgTempC,
    required this.avgTempF,
    required this.maxWindMph,
    required this.maxWindKph,
    required this.totalPrecipMm,
    required this.totalPrecipIn,
    required this.totalSnowCm,
    required this.avgVisKm,
    required this.avgVisMiles,
    required this.avgHumidity,
    required this.dailyWillItRain,
    required this.dailyChanceOfRain,
    required this.dailyWillItSnow,
    required this.dailyChanceOfSnow,
    required this.condition,
    required this.uv,
  });

  factory DayModel.fromJson(Map<String, dynamic> json) {
    return DayModel(
      maxTempC: json['maxtemp_c'].round(),
      maxTempF: json['maxtemp_f'].round(),
      minTempC: json['mintemp_c'].round(),
      minTempF: json['mintemp_f'].round(),
      avgTempC: json['avgtemp_c'].round(),
      avgTempF: json['avgtemp_f'].round(),
      maxWindMph: json['maxwind_mph'],
      maxWindKph: json['maxwind_kph'],
      totalPrecipMm: json['totalprecip_mm'],
      totalPrecipIn: json['totalprecip_in'],
      totalSnowCm: json['totalsnow_cm'],
      avgVisKm: json['avgvis_km'],
      avgVisMiles: json['avgvis_miles'],
      avgHumidity: json['avghumidity'],
      dailyWillItRain: json['daily_will_it_rain'],
      dailyChanceOfRain: json['daily_chance_of_rain'],
      dailyWillItSnow: json['daily_will_it_snow'],
      dailyChanceOfSnow: json['daily_chance_of_snow'],
      condition: ConditionModel.fromJson(json['condition']),
      uv: json['uv'],
    );
  }
}
