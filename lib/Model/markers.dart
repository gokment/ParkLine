import 'package:cloud_firestore/cloud_firestore.dart';

class MarkersM {
  String place;
  GeoPoint latitude;
  GeoPoint longitude;
  static MarkersM currentMarker;
  MarkersM({this.place, this.latitude, this.longitude});
  factory MarkersM.fromJson(Map<String, dynamic> j) => MarkersM(
      place: j['place'], latitude: j['latitude'], longitude: j['longitude']);
  Map<String, dynamic> toMap() =>
      {"place": place, "latitude": latitude, "longitude": longitude};
}
