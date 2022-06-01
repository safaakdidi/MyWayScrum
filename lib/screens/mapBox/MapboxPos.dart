import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:googleads/Layout/footer.dart';
import 'package:googleads/Layout/theme_helper.dart';

import 'package:googleads/helpers/shared_prefs.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:googleads/main.dart';
import 'package:googleads/screens/authenticate/forgot_password_verification_page.dart';
import 'package:googleads/screens/authenticate/sign_in.dart';
import 'package:googleads/screens/mapBox/prepare_ride.dart';
import 'package:googleads/screens/sign_up/registration_page1.dart';
import 'package:googleads/wrapper.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mapbox_gl/mapbox_gl.dart';



class MapPos extends StatefulWidget {
  const MapPos({Key? key}) : super(key: key);

  @override
  State<MapPos> createState() => _MapPosState();
}

class _MapPosState extends State<MapPos> {
  double  _drawerIconSize = 24;
  double _drawerFontSize = 17;
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
    Color _primaryColor = HexColor('#80FF72');
    Color _accentColor = HexColor('#7EE8FA');
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
               bottom: 56.0,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          Column(
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
                                const SizedBox(height: 60),

                              ]),
                          SizedBox(width:25.0),
                          Container(
                            decoration: ThemeHelper().buttonBoxDecoration(context),
                            child: RaisedButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const PrepareRide())),
                              shape: ThemeHelper().Shape(),
                              padding: EdgeInsets.all(0.0),
                              child:ThemeHelper().inkStyle(context,"Where To Go!") ,
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Footer()
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    ) ;
  }



}

