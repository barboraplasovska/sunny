import 'package:flutter/material.dart';
import 'package:sunny/pages/home/home_page.dart';
import 'package:sunny/services/shared_prefs_service.dart';

class FetchCities extends StatefulWidget {
  final String? city;
  const FetchCities({super.key, this.city});

  @override
  State<FetchCities> createState() => _FetchCitiesState();
}

class _FetchCitiesState extends State<FetchCities> {
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
            return HomePage(
              cities: snapshot.data!,
              city: widget.city,
            );
          }
        });
  }
}
