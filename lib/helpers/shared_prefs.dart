import 'dart:convert';

import 'package:googleads/data/staions_list1.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:googleads/main.dart';
LatLng getLatLngFromSharedPrefs() {
  return LatLng(sharedPreferences.getDouble('latitude')!,
      sharedPreferences.getDouble('longitude')!);
}
String getCurrentAddressFromSharedPrefs() {
  return sharedPreferences.getString('current-address')!;
}

LatLng getCurrentLatLngFromSharedPrefs() {
  return LatLng(sharedPreferences.getDouble('latitude')!,
      sharedPreferences.getDouble('longitude')!);
}

Map getDecodedResponseFromSharedPrefs(int index) {
  String key = 'restaurant--$index';
  Map response = json.decode(sharedPreferences.getString(key)!);
  return response;
}

num getDistanceFromSharedPrefs(int index) {
  num distance = getDecodedResponseFromSharedPrefs(index)['distance'];
  return distance;
}

num getDurationFromSharedPrefs(int index) {
  num duration = getDecodedResponseFromSharedPrefs(index)['duration'];
  return duration;
}

Map getGeometryFromSharedPrefs(int index) {
  Map geometry = getDecodedResponseFromSharedPrefs(index)['geometry'];
  return geometry;
}
// String getSourceAndDestinationPlaceText(String type) {
//   String sourceAddress =
//   json.decode(sharedPreferences.getString('source')!)['name'];
//   String destinationAddress =
//   json.decode(sharedPreferences.getString('destination')!)['name'];
//
//   if (type == 'source') {
//     return sourceAddress;
//   } else {
//     return destinationAddress;
//   }
//}
LatLng getTripLatLngFromSharedPrefs(String type) {
  String sourstationName =
  json.decode(sharedPreferences.getString('source')!);
  final stations = Stations_list.All_Stations.firstWhere(
          (station) => station.getName() == sourstationName,
     );
  LatLng source = LatLng(stations.getLat(), stations.getLong());
  String desstationName = json.decode(sharedPreferences.getString('destination')!);
  final stationd = Stations_list.All_Stations.firstWhere(
        (station) => station.getName() == desstationName,
  );
  LatLng destination = LatLng(stationd.getLat(), stationd.getLong());

  if (type == 'source') {
    return source;
  } else {
    return destination;
  }
}
