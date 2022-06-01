import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:googleads/Layout/footer.dart';
import 'package:googleads/Layout/theme_helper.dart';
import 'package:googleads/helpers/commons.dart';
import 'package:googleads/helpers/map-box_handler.dart';
import 'package:googleads/screens/mapBox/MapboxPos.dart';
import 'package:mapbox_gl/mapbox_gl.dart';


class ReviewRide extends StatefulWidget {
  final Map modifiedResponse;
  const ReviewRide({Key? key, required this.modifiedResponse})
      : super(key: key);

  @override
  State<ReviewRide> createState() => _ReviewRideState();
}

class _ReviewRideState extends State<ReviewRide> {
  // Mapbox Maps SDK related
  final List<CameraPosition> _kTripEndPoints = [];
  late MapboxMapController controller;
  late CameraPosition _initialCameraPosition;

  // Directions API response related
  late String distance;
  late String dropOffTime;
  late Map geometry;

  @override
  void initState() {
    // initialise distance, dropOffTime, geometry
    _initialiseDirectionsResponse();

    // initialise initialCameraPosition, address and trip end points
    _initialCameraPosition = CameraPosition(
        target: getCenterCoordinatesForPolyline(geometry), zoom: 11);
    print("555555555555555555555555555555555555555555555555555555555555555555555");
List geom=widget.modifiedResponse['geometry']['coordinates'];
//print(geom);
double d=geom[0][0];
print(d);

_kTripEndPoints.add(CameraPosition(target:LatLng(geom[0][1],geom[0][0])));
_kTripEndPoints.add(CameraPosition(target:LatLng(geom[geom.length-1][1],geom[geom.length-1][0])));



    // for (String type in ['source', 'destination']) {
    //   _kTripEndPoints
    //       .add(CameraPosition(target: getTripLatLngFromSharedPrefs(type)));
    // }
    super.initState();
  }

  _initialiseDirectionsResponse() {
    distance = (widget.modifiedResponse['distance'] / 1000).toStringAsFixed(1);
    dropOffTime = getDropOffTime(widget.modifiedResponse['duration']);
    geometry = widget.modifiedResponse['geometry'];
  }

  _onMapCreated(MapboxMapController controller) async {
    this.controller = controller;
  }

  _onStyleLoadedCallback() async {
    for (int i = 0; i < _kTripEndPoints.length; i++) {
      String iconImage = i == 0 ? 'circle' : 'square';
      await controller.addSymbol(
        SymbolOptions(
          geometry: _kTripEndPoints[i].target,
          iconSize: 0.1,
          iconImage: "assets/icon/$iconImage.png",
        ),
      );
    }
    _addSourceAndLineLayer();
  }

  _addSourceAndLineLayer() async {
    // Create a polyLine between source and destination
    final _fills = {
      "type": "FeatureCollection",
      "features": [
        {
          "type": "Feature",
          "id": 0,
          "properties": <String, dynamic>{},
          "geometry": geometry,
        },
      ],
    };

    // Add new source and lineLayer
    await controller.addSource("fills", GeojsonSourceProperties(data: _fills));
    await controller.addLineLayer(
      "fills",
      "lines",
      LineLayerProperties(
        lineColor: Colors.indigo.toHexStringRGB(),
        lineCap: "round",
        lineJoin: "round",
        lineWidth: 3,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ride Left" ,
            style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold)
        ),
        elevation: 0.5 ,
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end : Alignment.bottomRight ,
                  colors: <Color>[Theme.of(context).primaryColor , Theme.of(context).accentColor]
              ),
            )
        ),
        actions: [
          Container(
              margin: EdgeInsets.only(top: 16, right: 16),
              child:Stack(
                children: <Widget>[
                  Icon(Icons.notifications),
                  Positioned(right: 0,
                      child: Container(
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(6),),
                        constraints : BoxConstraints(minWidth: 12 , minHeight: 12) ,
                        child: Text('5', style: TextStyle(color: Colors.white , fontSize: 8), textAlign: TextAlign.center,),


                      )
                  )
                ],
              )
          )
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: MapboxMap(
                accessToken: dotenv.env['MAPBOX_ACCESS_TOKEN'],
                initialCameraPosition: _initialCameraPosition,
                onMapCreated: _onMapCreated,
                onStyleLoadedCallback: _onStyleLoadedCallback,
                myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
                minMaxZoomPreference: const MinMaxZoomPreference(14, 17),
              ),
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
                              const Text('Time left to arrive :'),
                              Text((widget.modifiedResponse['duration']/60).round().toString()+" min",
                                  style: const TextStyle(color: Colors.indigo)),
                              const SizedBox(height: 20),
                                 const Text('The metro will arrive at :'),
                              Text(dropOffTime,
                                  style: const TextStyle(color: Colors.indigo)),
                              const SizedBox(height: 20),


                            ]),
                        SizedBox(width: 20.0,),
                        Container(
                          decoration: ThemeHelper().buttonBoxDecoration(context),
                          child: RaisedButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const MapPos())),
                            shape: ThemeHelper().Shape(),
                            padding: EdgeInsets.all(0.0),
                            child:ThemeHelper().inkStyle(context,"Go Back To Map") ,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Footer()
            //reviewRideBottomSheet(context, distance, dropOffTime),
          ],
        ),
      ),
    );
  }
}