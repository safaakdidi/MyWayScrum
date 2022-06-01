import 'package:flutter/material.dart';
import 'package:googleads/data/staions_list1.dart';
import 'package:googleads/main.dart';
import 'package:googleads/screens/mapBox/MapboxPos.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import '../../helpers/directions_handler.dart';
import 'dart:convert';


class Pos_config extends StatefulWidget {
  const Pos_config({Key? key}) : super(key: key);

  @override
  State<Pos_config> createState() => _Pos_configState();
}

class _Pos_configState extends State<Pos_config> {
  @override
  void initState() {
    super.initState();
    initializeLocationAndSave();
  }

  void initializeLocationAndSave() async {
    // Ensure all permissions are collected for Locations
    Location _location = Location();
    bool? _serviceEnabled;
    PermissionStatus? _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
    }

    // Get capture the current user location
    LocationData _locationData = await _location.getLocation();
    LatLng currentLatLng = LatLng(_locationData.latitude!, _locationData.longitude!);

    // Store the user location in sharedPreferences
    sharedPreferences.setDouble('latitude', _locationData.latitude!);
    sharedPreferences.setDouble('longitude', _locationData.longitude!);
    // Get and store the directions API response in sharedPreferences

    for (int i = 0; i < Stations_list.All_Stations.length; i++) {
    Map modifiedResponse = await getDirectionsAPIResponse(currentLatLng, i);
     saveDirectionsAPIResponse(i, json.encode(modifiedResponse));
     }
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const MapPos()),
            (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
  }


