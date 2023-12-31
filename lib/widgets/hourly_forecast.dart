import 'package:flutter/material.dart';
import 'package:sunny/models/hourly_model.dart';
import 'package:sunny/services/weather_service.dart';

class HourlyForecastWidget extends StatelessWidget {
  final List<HourlyModel> hourlyForecast;
  const HourlyForecastWidget({
    Key? key,
    required this.hourlyForecast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int currentHour = getCurrentHour();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.secondary,
      ),
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Icon(
                  Icons.access_time,
                  color: Theme.of(context).colorScheme.tertiary,
                  size: 16,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "HOURLY FORECAST",
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 85,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: hourlyForecast.length,
              itemBuilder: (context, index) {
                final hour = hourlyForecast[index];
                int hourValue = getHour(hour.time);

                bool isCurrentHour = (hourValue == currentHour);

                return SizedBox(
                  width: 60,
                  child: Column(
                    children: [
                      Text(isCurrentHour ? 'Now' : '$hourValue'),
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: Image.network(
                          'http:${hour.condition.icon}',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text('${hour.tempC.toString()}°C'),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
