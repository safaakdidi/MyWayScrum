import 'package:flutter/material.dart';
import 'package:googleads/Layout/footer.dart';
import 'package:googleads/Layout/theme_helper.dart';
import 'package:googleads/data/staions_list1.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:googleads/helpers/commons.dart';
import 'package:googleads/widgets/carousel_card.dart';

import 'package:googleads/helpers/shared_prefs.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:googleads/screens/mapBox/prepare_ride.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:animate_icons/animate_icons.dart';




class MapPos extends StatefulWidget {
  const MapPos({Key? key}) : super(key: key);

  @override
  State<MapPos> createState() => _MapPosState();
}

class _MapPosState extends State<MapPos> {
  double  _drawerIconSize = 24;
  double _drawerFontSize = 17;
  late AnimateIconController controll;


  LatLng latLng = getLatLngFromSharedPrefs();
 // late String currentAddress;
  late CameraPosition _initialCameraPosition;
  late MapboxMapController controller;

  late List<CameraPosition> _kStationsList;
  List<Map> carouselData = [];

  // Carousel related
  int pageIndex = 0;
  bool accessed = false;
  late List<Widget> carouselItems;

@override
  void initState() {
    // TODO: implement initState
  _initialCameraPosition = CameraPosition(target: latLng, zoom: 15);
  controll = AnimateIconController();


  //currentAddress = getCurrentAddressFromSharedPrefs();

  // Calculate the distance and time from data in SharedPreferences
  for (int index = 0; index < Stations_list.All_Stations.length; index++) {
    num distance = getDistanceFromSharedPrefs(index) / 1000;
    num duration = getDurationFromSharedPrefs(index) / 60;
    carouselData.add({'index': index, 'distance': distance, 'duration': duration});}
  carouselData.sort((a, b) => a['duration'] < b['duration'] ? 0 : 1);


  // Generate the list of carousel widgets
  carouselItems = List<Widget>.generate(
      Stations_list.All_Stations.length,
          (index) => carouselCard(carouselData[index]['index'],
          carouselData[index]['distance'], carouselData[index]['duration']));
  // initialize map symbols in the same order as carousel widgets
  _kStationsList = List<CameraPosition>.generate(
      Stations_list.All_Stations.length,
          (index) => CameraPosition(
          target: getLatLngFromRestaurantData(carouselData[index]['index']),
          zoom: 15));
  super.initState();
  }
  _addSourceAndLineLayer(int index, bool removeLayer) async {
    // Can animate camera to focus on the item
    controller.animateCamera(
        CameraUpdate.newCameraPosition(_kStationsList[index]));

    // Add a polyLine between source and destination
    Map geometry = getGeometryFromSharedPrefs(carouselData[index]['index']);
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

    // Remove lineLayer and source if it exists
    if (removeLayer == true) {
      await controller.removeLayer("lines");
      await controller.removeSource("fills");
    }

    // Add new source and lineLayer
    await controller.addSource("fills", GeojsonSourceProperties(data: _fills));
    await controller.addLineLayer(
      "fills",
      "lines",
      LineLayerProperties(
        lineColor: Colors.pink.toHexStringRGB(),
        lineCap: "round",
        lineJoin: "round",
        lineWidth: 2,
      ),
    );
  }

  _onMapCreated(MapboxMapController controller) async {
    this.controller = controller;
  }
  _onStyleLoadedCallback() async {
    for (CameraPosition _kRestaurant in _kStationsList) {
      await controller.addSymbol(
        SymbolOptions(
          geometry: _kRestaurant.target,
          iconSize: 0.2,
          iconImage: "assets/station.png",
        ),
      );
    }
    _addSourceAndLineLayer(0, false);
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
              CarouselSlider(
                items: carouselItems,
                options: CarouselOptions(
                  height: 100,
                  viewportFraction: 0.6,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  scrollDirection: Axis.horizontal,
                  onPageChanged:
                      (int index, CarouselPageChangedReason reason) async {
                    setState(() {
                      pageIndex = index;
                    });
                    _addSourceAndLineLayer(index, true);
                  },
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
        child: const Icon(Icons.my_location ,color: Colors.blue, ),

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    ) ;
  }



}

