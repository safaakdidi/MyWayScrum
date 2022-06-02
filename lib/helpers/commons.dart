import 'package:intl/intl.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:googleads/data/staions_list1.dart';

String getDropOffTime(num duration) {
  int minutes = (duration / 60).round();
  int seconds = (duration % 60).round();
  DateTime tripEndDateTime =
  DateTime.now().add(Duration(minutes: minutes, seconds: seconds));
  String dropOffTime = DateFormat.jm().format(tripEndDateTime);
  return dropOffTime;
}

LatLng getLatLngFromRestaurantData(int index) {
  return LatLng(  Stations_list.All_Stations[index].getLat(),
      Stations_list.All_Stations[index].getLong());
}