import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sunny/models/forecast_model.dart';

class TenDayForecast extends StatelessWidget {
  final List<ForecastModel> dayForecast;
  const TenDayForecast({
    super.key,
    required this.dayForecast,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), // Adjust the value as desired
        color: Theme.of(context).colorScheme.secondary,
      ),
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Icon(Icons.calendar_month_outlined),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "10-day forecast",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: dayForecast.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final day = dayForecast[index];

              DateTime date = DateTime.parse(day.date);
              String formattedDay = getFormattedDay(date);

              bool isToday = DateTime.now().day == date.day;

              return Container(
                padding: const EdgeInsets.only(left: 10, top: 5),
                child: Row(
                  children: [
                    Text(
                      isToday ? 'Today' : formattedDay,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 22,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: Image.network(
                        'http:${day.day.condition.icon}',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        '${day.day.minTempC.toString()}°C-${day.day.maxTempC.toString()}°C',
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

String getFormattedDay(DateTime date) {
  String day = DateFormat('EEEE').format(date);
  return day.substring(0, 3);
}
