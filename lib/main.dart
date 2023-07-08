import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sunny/pages/home/fetch_cities.dart';
import 'package:sunny/services/geolocator_service.dart';
import 'package:sunny/services/shared_prefs_service.dart';
import 'package:sunny/styles/theme.dart';

Future<void> addCurrentLocationCity() async {
  String longLat = await getLongLangFromPosition();
  await setLocationCity(longLat);
}

void main() async {
  await dotenv.load();
  await addCurrentLocationCity();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sunny',
      theme: sunnyTheme,
      home: const FetchCities(),
    );
  }
}
