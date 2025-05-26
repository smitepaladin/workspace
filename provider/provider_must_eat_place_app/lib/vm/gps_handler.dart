import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GpsModel with ChangeNotifier{
  String latitude = '';
  String longitude = '';

  Future<void> checkLocationPermission() async{
    LocationPermission permission = await Geolocator.checkPermission(); // 허용할때까지 기다린다.

    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission(); // 거부하면 한번더 물어본다.
    }

    if(permission == LocationPermission.deniedForever) return; // 리턴만 시킨다

    if(permission == LocationPermission.whileInUse || permission == LocationPermission.always){
      final position = await Geolocator.getCurrentPosition();
      latitude = position.latitude.toString();
      longitude = position.longitude.toString();
      notifyListeners();
    }
  }
}