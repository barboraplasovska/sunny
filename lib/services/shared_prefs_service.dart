import 'package:shared_preferences/shared_preferences.dart';

Future<List<String>> getSavedCities() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? path = prefs.getStringList('cities');
  return path ?? ["Paris", "London"];
}

bool includesCity(List<String> cities, String city) {
  for (var p in cities) {
    if (p == city) {
      return true;
    }
  }
  return false;
}

Future<void> addCity(String city) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  List<String> current = await getSavedCities();

  if (!includesCity(current, city)) {
    current.add(city);
    await prefs.setStringList('cities', current);
  }
}

Future<void> removeCityAt(int index) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  List<String> current = await getSavedCities();
  current.removeAt(index);

  await prefs.setStringList('cities', current);
}

Future<void> setLocationCity(String city) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  List<String> current = await getSavedCities();

  current.insert(0, city);
  current.removeAt(1);
  await prefs.setStringList('cities', current);
}
