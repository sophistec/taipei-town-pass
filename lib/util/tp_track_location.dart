import 'dart:async';

import 'package:geolocator/geolocator.dart';

class TPTrackLocation {

  static Future<bool> checkAndRequestPermission()async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.whileInUse &&
        permission != LocationPermission.always) {
      return Future.error('Location permissions are denied');
    }
    }

    return true;
  }

  static Stream<Position> getLocationStream({
    LocationAccuracy accuracy = LocationAccuracy.high,
    int distanceFilter = 100,
  }) async* {
    if (await checkAndRequestPermission()) {
      yield* Geolocator.getPositionStream(
        locationSettings: LocationSettings(accuracy: accuracy,
          distanceFilter: distanceFilter,
        ),
      );
    }
  }
}