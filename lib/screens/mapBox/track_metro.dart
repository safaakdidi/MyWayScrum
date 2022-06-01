import 'package:flutter/material.dart';
import 'package:googleads/main.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart' as loc;

class MapPos extends StatefulWidget {
  final String user_id;
  const MapPos({Key? key, required this.user_id}) : super(key: key);


  @override
  State<MapPos> createState() => _MapPosState();
}

class _MapPosState extends State<MapPos> {
  final loc.Location location = loc.Location();
  late MapboxMapController controller;
  bool _added = false;
  _onStyleLoadedCallback() async {

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('location').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (_added) {
              mymap(snapshot);
            }
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return SafeArea(
              child: Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: MapboxMap(
                        accessToken: dotenv.env['MAPBOX_ACCESS_TOKEN'],
                        initialCameraPosition: CameraPosition(
                            target: LatLng(
                              snapshot.data!.docs.singleWhere(
                                      (element) => element.id == widget.user_id)['latitude'],
                              snapshot.data!.docs.singleWhere(
                                      (element) => element.id == widget.user_id)['longitude'],
                            ),
                            zoom: 14.47),
                        onMapCreated: (MapboxMapController controller1) async {
                          setState(() {
                            controller = controller1;
                            _added = true;
                          });
                        },
                        onStyleLoadedCallback: _onStyleLoadedCallback,
                        myLocationEnabled: true,
                        myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
                        minMaxZoomPreference: const MinMaxZoomPreference(14, 17),
                      ),
                    ),
                  ]
              ),
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        },
        child: const Icon(Icons.my_location),
      ),
    ) ;
  }

  Future<void> mymap(AsyncSnapshot<QuerySnapshot> snapshot) async {
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(
          snapshot.data!.docs.singleWhere(
                  (element) => element.id == widget.user_id)['latitude'],
          snapshot.data!.docs.singleWhere(
                  (element) => element.id == widget.user_id)['longitude'],
        ),
        zoom: 14.47)));
  }


}

