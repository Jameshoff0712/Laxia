import 'dart:async';

import 'package:geolocator/geolocator.dart';

class GeoLocationService {
  Future<Position> getLocation() async {
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high, forceAndroidLocationManager: true);
  }
}
