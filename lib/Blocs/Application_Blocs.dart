import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:parkline/Services/Geolocator_Services.dart';

class ApplicationBlocs with ChangeNotifier{
  final geoLocatorServices = GeolocatorServices();

  //Variables
  Position currentLocation;

  ApplicationBlocs(){
    setCurrentLocation();
  }
  setCurrentLocation() async{
    currentLocation = await geoLocatorServices.getCurrentPosition();
    notifyListeners();
}
}