import 'package:flutter/material.dart';
import 'package:googleads/helpers/shared_prefs.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_gl/mapbox_gl.dart';



class MapPos extends StatefulWidget {
  const MapPos({Key? key}) : super(key: key);

  @override
  State<MapPos> createState() => _MapPosState();
}

class _MapPosState extends State<MapPos> {
  LatLng latLng = getLatLngFromSharedPrefs();
  late CameraPosition _initialCameraPosition;
  late MapboxMapController controller;
@override
  void initState() {
    // TODO: implement initState
  _initialCameraPosition = CameraPosition(target: latLng, zoom: 15);

  super.initState();
  }
  _onMapCreated(MapboxMapController controller) async {
    this.controller = controller;
  }
  _onStyleLoadedCallback() async {

    }
  @override
  Widget build(BuildContext context) {
    _initialCameraPosition = CameraPosition(target: latLng, zoom: 15);

    return Scaffold(
      body: SafeArea(
        child: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: MapboxMap(
                  accessToken: dotenv.env['MAPBOX_ACCESS_TOKEN'],
                  initialCameraPosition: _initialCameraPosition,
                  onMapCreated: _onMapCreated,
                  onStyleLoadedCallback: _onStyleLoadedCallback,
                  myLocationEnabled: true,
                  myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
                  minMaxZoomPreference: const MinMaxZoomPreference(14, 17),
                ),
              ),
              ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.animateCamera(
              CameraUpdate.newCameraPosition(_initialCameraPosition));
        },
        child: const Icon(Icons.my_location),
      ),
    ) ;
  }



}

