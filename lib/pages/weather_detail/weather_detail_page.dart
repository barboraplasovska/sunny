import 'package:flutter/material.dart';
import 'package:sunny/models/condition_model.dart';
import 'package:sunny/models/forecast_model.dart';
import 'package:sunny/models/hourly_model.dart';
import 'package:sunny/models/location_model.dart';
import 'package:sunny/models/weather_model.dart';
import 'package:sunny/services/weather_service.dart';
import 'package:sunny/widgets/hourly_forecast.dart';
import 'package:sunny/widgets/ten_day_forecast.dart';
import 'package:sunny/widgets/weather_widget.dart';

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

  String getVisibilityDescription(int visibility) {
    if (visibility >= 10) return 'It\'s perfectly clear right now';
    if (visibility >= 1) return 'Reduced visibility.';
    return 'Visibility is severely impaired';
  }

  String getFeelsLikeDescription(WeatherModel model) {
    if (model.humidity >= 50 && model.feelslikeC >= model.tempC) {
      return 'Humidity is making it weel warmer';
    }
    if (model.feelslikeC <= model.tempC && model.windKph >= 10) {
      return 'Wind is making it feel cooler';
    }
    return "Similar to actual temperature.";
  }

  String getWindDescription(String direction) {
    switch (direction) {
      case 'N':
        return 'The wind is coming from the north';
      case 'NE':
        return 'The wind is coming from the northeast';
      case 'E':
        return 'The wind is coming from the east';
      case 'SE':
        return 'The wind is coming from the southeast';
      case 'S':
        return 'The wind is coming from the south';
      case 'SW':
        return 'The wind is coming from the southwest';
      case 'W':
        return 'The wind is coming from the west';
      case 'NW':
        return 'The wind is coming from the northwest';
      default:
        return 'The wind direction is unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    WeatherModel model = widget.model;
    LocationModel location = model.location;
    ConditionModel condition = model.condition;
    List<ForecastModel> forecast = model.forecast;

    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
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
                height: 15,
              ),
              TenDayForecast(dayForecast: forecast),
              SizedBox(
                height: 320,
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  primary: false,
                  padding: const EdgeInsets.only(top: 15),
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                  children: <Widget>[
                    WeatherWidget(
                      icon: Icons.thermostat_sharp,
                      widgetTitle: "Feels like",
                      title: '${model.feelslikeC}°',
                      description: getFeelsLikeDescription(model),
                    ),
                    WeatherWidget(
                      icon: Icons.water_drop_outlined,
                      widgetTitle: "Humidity",
                      title: '${model.humidity}%',
                    ),
                    WeatherWidget(
                      icon: Icons.visibility,
                      widgetTitle: "Visibility",
                      title: '${model.visKm} km',
                      description: getVisibilityDescription(model.visKm),
                    ),
                    WeatherWidget(
                      icon: Icons.air,
                      widgetTitle: "Wind",
                      title: '${model.windKph} km/h',
                      description: getWindDescription(model.windDir),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
