// ignore_for_file: avoid_print

import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longitude;

  Future<void> getCurrentlocation() async {
try{
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium);
    latitude = position.latitude;
    longitude = position.longitude;
    // print(latitude);
    // print(longitude);
}
catch(e){
  print(e);
}
  }
}
