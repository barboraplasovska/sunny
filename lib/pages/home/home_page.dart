import 'package:flutter/material.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:sunny/models/weather_model.dart';
import 'package:sunny/pages/weather_detail/weather_detail_page.dart';
import 'package:sunny/services/shared_prefs_service.dart';
import 'package:sunny/services/weather_service.dart';
import 'package:sunny/widgets/add_city_popup.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherService _weatherService = WeatherService();
  List<String> cities = ["Paris", "London"];

  int _currentIndex = 0;
  Map<String, WeatherModel?> cachedWeatherData = {};
  Map<String, DateTime> lastFetchTimes = {};

  final PageController _pageController = PageController();

  Future<void> fetchCities() async {
    List<String> newCities = await getSavedCities();
    setState(() {
      cities = newCities;
    });
  }

  @override
  void initState() {
    fetchCities();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<WeatherModel?> fetchWeatherData(String city) async {
    WeatherModel? weatherModel;

    try {
      weatherModel = await _weatherService.fetchWeatherData(city);
    } catch (error) {
      print('Error fetching weather data: $error');
    }

    return weatherModel;
  }

  Widget buildBody(String city, int index) {
    _currentIndex = index;

    if (cachedWeatherData.containsKey(city)) {
      final weatherModel = cachedWeatherData[city];

      if (weatherModel != null) {
        return WeatherDetail(model: weatherModel);
      }
    }

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
            cachedWeatherData[city] = weatherModel;
            lastFetchTimes[city] = DateTime.now();
            return WeatherDetail(model: weatherModel);
          } else {
            return const Center(
              child: Text('No weather data available'),
            );
          }
        }
      },
    );
  }

  bool shouldFetchData(String city) {
    if (!lastFetchTimes.containsKey(city)) {
      return true;
    }

    final lastFetchTime = lastFetchTimes[city];
    final currentTime = DateTime.now();
    final timeDifference = currentTime.difference(lastFetchTime!);

    return timeDifference.inMinutes >= 5;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        alignment: Alignment.centerRight,
        children: [
          Container(
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: cities.length,
                    itemBuilder: (context, index) {
                      final city = cities[index];

                      if (shouldFetchData(city)) {
                        return buildBody(city, index);
                      } else {
                        final weatherModel = cachedWeatherData[city];

                        if (weatherModel != null) {
                          return WeatherDetail(model: weatherModel);
                        } else {
                          return const Center(
                            child: Text('No weather data available'),
                          );
                        }
                      }
                    },
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                ),
                Container(
                  height: 60,
                  color: Theme.of(context).colorScheme.background,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: PageViewDotIndicator(
                      currentItem: _currentIndex,
                      count: cities.length,
                      size: const Size(8, 8),
                      unselectedSize: const Size(8, 8),
                      unselectedColor: Colors.grey,
                      selectedColor: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 4,
            top: 55,
            child: IconButton(
              splashRadius: 20,
              color: Theme.of(context).colorScheme.tertiary,
              onPressed: () {
                setState(() {
                  showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const AddCityPopup();
                          })
                      .then((value) => {
                            fetchCities(),
                          })
                      .whenComplete(
                        () => setState(() {
                          _currentIndex = cities.length - 1;
                        }),
                      );
                });
              },
              icon: const Icon(
                Icons.add,
                size: 35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
