import 'package:geolocator/geolocator.dart';

// returns true if we have permission
Future<bool> requestLocationPermission() async {
  var permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    await Geolocator.requestPermission();
  }

  permission = await Geolocator.checkPermission();
  return permission != LocationPermission.deniedForever;
}

Future<String> getLongLangFromPosition() async {
  bool permission = await requestLocationPermission();
  if (!permission) {
    return "Not permitted";
  }

  final position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  return '${position.latitude},${position.longitude}';
}
