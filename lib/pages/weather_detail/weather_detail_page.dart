import 'package:flutter/material.dart';
import 'package:sunny/models/condition_model.dart';
import 'package:sunny/models/forecast_model.dart';
import 'package:sunny/models/hourly_model.dart';
import 'package:sunny/models/location_model.dart';
import 'package:sunny/models/weather_model.dart';
import 'package:sunny/services/weather_service.dart';
import 'package:sunny/widgets/hourly_forecast.dart';
import 'package:sunny/widgets/ten_day_forecast.dart';

class WeatherDetail extends StatefulWidget {
  final WeatherModel model;
  const WeatherDetail({
    super.key,
    required this.model,
  });

  @override
  State<WeatherDetail> createState() => _WeatherDetailState();
}

class _WeatherDetailState extends State<WeatherDetail> {
  List<HourlyModel> getHourlyForecast(List<ForecastModel> forecasts) {
    int currentHour = getCurrentHour();
    List<HourlyModel> hourlyForecast = [];

    for (HourlyModel hourlyModel in forecasts[0].hourlyForecast) {
      int forecastHour = getHour(hourlyModel.time);

      if (forecastHour >= currentHour) {
        hourlyForecast.add(hourlyModel);
      }
    }

    for (HourlyModel hourlyModel in forecasts[1].hourlyForecast) {
      int forecastHour = getHour(hourlyModel.time);

      if (forecastHour < currentHour) {
        hourlyForecast.add(hourlyModel);
      }
    }

    return hourlyForecast;
  }

  @override
  Widget build(BuildContext context) {
    WeatherModel model = widget.model;
    LocationModel location = model.location;
    ConditionModel condition = model.condition;
    List<ForecastModel> forecast = model.forecast;

    return Center(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 90),
                child: Text(
                  location.name,
                  style: const TextStyle(fontSize: 30),
                ),
              ),
              Text(
                '${model.tempC}°',
                style: const TextStyle(
                  fontSize: 80,
                ),
              ),
              Text(
                condition.text,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                'H:${forecast[0].day.maxTempC}° L:${forecast[0].day.minTempC}°',
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              HourlyForecastWidget(
                hourlyForecast: getHourlyForecast(forecast),
              ),
              const SizedBox(
                height: 20,
              ),
              TenDayForecast(dayForecast: forecast),
            ],
          ),
        ),
      ),
    );
  }
}
