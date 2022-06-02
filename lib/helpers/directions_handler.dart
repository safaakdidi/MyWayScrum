import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:googleads/main.dart';

import '../data/staions_list1.dart';
import '../requests/mapbox_requests.dart';

Future<Map> getDirectionsAPIResponse(LatLng currentLatLng, int index) async {
  final response = await getCyclingRouteUsingMapbox(
      currentLatLng,
      LatLng(Stations_list.All_Stations[index].getLat(),Stations_list.All_Stations[index].getLong()));
  Map geometry = response['routes'][0]['geometry'];
  num duration = response['routes'][0]['duration'];
  num distance = response['routes'][0]['distance'];
  print('-------------------${Stations_list.All_Stations[index].getName()}-------------------');
  print(distance);
  print(duration);

  Map modifiedResponse = {
    "geometry": geometry,
    "duration": duration,
    "distance": distance,
  };
  return modifiedResponse;
}

void saveDirectionsAPIResponse(int index, String response) {
  sharedPreferences.setString('restaurant--$index', response);
}
