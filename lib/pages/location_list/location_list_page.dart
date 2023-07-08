import 'package:flutter/material.dart';
import 'package:sunny/models/weather_model.dart';
import 'package:sunny/pages/home/fetch_cities.dart';
import 'package:sunny/services/shared_prefs_service.dart';
import 'package:sunny/services/weather_service.dart';
import 'package:sunny/widgets/add_city_popup.dart';

class LocationListPage extends StatefulWidget {
  const LocationListPage({super.key});

  @override
  State<LocationListPage> createState() => _LocationListPageState();
}

class _LocationListPageState extends State<LocationListPage> {
  final WeatherService _weatherService = WeatherService();
  late List<String> cities;

  Future<WeatherModel?> fetchWeatherData(String city) async {
    WeatherModel? weatherModel;

    try {
      weatherModel = await _weatherService.fetchWeatherData(city);
    } catch (error) {
      print('Error fetching weather data: $error');
    }

    return weatherModel;
  }

  Widget buildTile(WeatherModel model) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.primary,
        ),
        height: 120,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.location.name,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    model.condition.text,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${model.tempC}°',
                    style: const TextStyle(
                      fontSize: 50,
                    ),
                  ),
                  Text(
                    'H:${model.forecast[0].day.maxTempC}° L:${model.forecast[0].day.minTempC}°',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFutureTile(String city) {
    return FutureBuilder<WeatherModel?>(
      future: fetchWeatherData(city),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          WeatherModel? weatherModel = snapshot.data;

          if (weatherModel != null) {
            return buildTile(weatherModel);
          } else {
            return const Center(
              child: Text('No weather data available'),
            );
          }
        }
      },
    );
  }

  void navigateToCityDetail(BuildContext context, city) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(microseconds: 500000),
        pageBuilder: (context, animation, secondaryAnimation) =>
            FetchCities(city: city),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return ScaleTransition(
            scale: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.fastOutSlowIn,
              ),
            ),
            child: child,
          );
        },
      ),
    );
  }

  Widget buildPage() {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 60,
            ),
            Row(
              children: [
                const Text(
                  "Weather",
                  style: TextStyle(
                    fontSize: 40,
                  ),
                ),
                const Spacer(),
                IconButton(
                  splashRadius: 20,
                  color: Theme.of(context).colorScheme.tertiary,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const AddCityPopup();
                        }).whenComplete(() => setState(() {}));
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 35,
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: cities.length,
                itemBuilder: (context, index) {
                  final item = cities[index];
                  return GestureDetector(
                    onTap: () {
                      navigateToCityDetail(context, cities[index]);
                    },
                    child: Dismissible(
                      direction: DismissDirection.endToStart,
                      key: Key(item),
                      onDismissed: (direction) async {
                        await removeCityAt(index);
                        setState(() {
                          cities.removeAt(index);
                        });
                      },
                      background: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 30),
                          child: const Icon(
                            Icons.delete_outlined,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                      ),
                      child: buildFutureTile(cities[index]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getSavedCities(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            cities = snapshot.data!;

            return buildPage();
          }
        });
  }
}
