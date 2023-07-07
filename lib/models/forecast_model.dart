import 'package:sunny/models/astro_model.dart';
import 'package:sunny/models/day_model.dart';
import 'package:sunny/models/hourly_model.dart';

class ForecastModel {
  final String date;
  final int dateEpoch;
  final DayModel day;
  final AstroModel astro;
  final List<HourlyModel> hourlyForecast;

  ForecastModel({
    required this.date,
    required this.dateEpoch,
    required this.day,
    required this.astro,
    required this.hourlyForecast,
  });

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    var hourList = json['hour'] as List<dynamic>;
    var hourlyForecastList =
        hourList.map((hourJson) => HourlyModel.fromJson(hourJson)).toList();

    return ForecastModel(
      date: json['date'],
      dateEpoch: json['date_epoch'],
      day: DayModel.fromJson(json['day']),
      astro: AstroModel.fromJson(json['astro']),
      hourlyForecast: hourlyForecastList,
    );
  }
}
