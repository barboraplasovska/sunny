import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sunny/pages/home/fetch_cities.dart';
import 'package:sunny/styles/theme.dart';

void main() async {
  await dotenv.load();
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
