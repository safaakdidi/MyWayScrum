import 'package:flutter/material.dart';
import 'package:googleads/Layout/theme_helper.dart';

import 'package:googleads/helpers/shared_prefs.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:googleads/screens/mapBox/prepare_ride.dart';
import 'package:mapbox_gl/mapbox_gl.dart';



class MapPos extends StatefulWidget {
  const MapPos({Key? key}) : super(key: key);

  @override
  State<MapPos> createState() => _MapPosState();
}

class _MapPosState extends State<MapPos> {
  LatLng latLng = getLatLngFromSharedPrefs();
  //late String currentAddress;
  late CameraPosition _initialCameraPosition;
  late MapboxMapController controller;
@override
  void initState() {
    // TODO: implement initState
  _initialCameraPosition = CameraPosition(target: latLng, zoom: 15);
  //currentAddress = getCurrentAddressFromSharedPrefs();

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
              MapboxMap(
                accessToken: dotenv.env['MAPBOX_ACCESS_TOKEN'],
                initialCameraPosition: _initialCameraPosition,
                onMapCreated: _onMapCreated,
                onStyleLoadedCallback: _onStyleLoadedCallback,
                myLocationEnabled: true,
                myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
                minMaxZoomPreference: const MinMaxZoomPreference(14, 17),
              ),
              Positioned(
                bottom: 0,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Hi there!',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 20),
                            const Text('You are currently here:'),
                            Text("currentAddress",
                                style: const TextStyle(color: Colors.indigo)),
                            const SizedBox(height: 20),
                            RaisedButton(
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const PrepareRide())),
                                shape: ThemeHelper().Shape(),
                                child:
                                ThemeHelper().inkStyle(context, "Where to Go?"),
                                // child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.center,
                                //     children: const [
                                //       Text('Where to Go?'),
                                //     ])
                            ),
                          ]),
                    ),
                  ),
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

