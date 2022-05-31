import 'package:flutter/material.dart';
import 'package:googleads/Layout/Frostedglass.dart';
import 'package:googleads/data/staions_list1.dart';
import 'package:googleads/helpers/shared_prefs.dart';
import 'package:googleads/screens/mapBox/review_ride.dart';
import 'package:googleads/widgets/endpoints_card.dart';
import 'package:googleads/widgets/search_listview.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:collection/collection.dart';
import 'package:lottie/lottie.dart';


class PrepareRide extends StatefulWidget {
  const PrepareRide({Key? key}) : super(key: key);

  @override
  State<PrepareRide> createState() => _PrepareRideState();

  // Declare a static function to reference setters from children
  static _PrepareRideState? of(BuildContext context) =>
      context.findAncestorStateOfType<_PrepareRideState>();
}

class _PrepareRideState extends State<PrepareRide> {
  bool isLoading = false;
  bool isEmptyResponse = true;
  bool hasResponded = false;
  bool isResponseForDestination = false;

  String noRequest = 'Please enter an address, a place or a location to search';
  String noResponse = 'No results found for the search';

  List<String> responses = [];
  TextEditingController sourceController = TextEditingController();
  TextEditingController destinationController = TextEditingController();

  // Define setters to be used by children widgets
  set responsesState(List<String> responses) {
    setState(() {
      this.responses = responses;
      hasResponded = true;
      isEmptyResponse = responses.isEmpty;
    });
    Future.delayed(
      const Duration(milliseconds: 500),
          () => setState(() {
        isLoading = false;
      }),
    );
  }

  set isLoadingState(bool isLoading) {
    setState(() {
      this.isLoading = isLoading;
    });
  }

  set isResponseForDestinationState(bool isResponseForDestination) {
    setState(() {
      this.isResponseForDestination = isResponseForDestination;
    });
  }

  @override
  List metros =[] ;
  bool visibility = true ;
  find_stations(depart,destination){

    metros =[] ;
    Stations_list.metro_list.forEach((lignes) =>
    {

      // if((lignes.stations.contains(depart))&&(lignes.stations.contains(destination))) {
      if(((lignes.stations.firstWhereOrNull((station)=>
      station.getName() == depart) )!=null)
          &&
          ((lignes.stations.firstWhereOrNull((station)=>
          station.getName() == destination) )!=null)) {

        metros.add(lignes)

      }

    }

    );

    return metros ;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map" ,
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
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: [
              endpointsCard(sourceController, destinationController),
              isLoading
                  ? const LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                  : Container(),
              isEmptyResponse
                  ? Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Center(
                      child: Text(hasResponded ? noResponse : noRequest)))
                  : Container(),
              searchListView(responses, isResponseForDestination,
                  destinationController, sourceController),
              Visibility( visible:visibility ,child:
              Column(
                children: [
                  SizedBox(height: 30,),
                  Container(
                    height: 130,
                    child:  ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: metros.length,
                        itemBuilder: (BuildContext context, int index) {return    Column(
                          children: [
                            GestureDetector(
                                child: FrostedGlassBox(      // theWidth is the width of the frostedglass
                                  theWidth: 130.0,
                                  // theHeight is the height of the frostedglass
                                  theHeight: 130.0,
                                  // theChild is the child of the frostedglass
                                  theChild:  Column(
                                    children: [
                                      Container(
                                          alignment: Alignment.center,
                                          child:Lottie.asset('assets/train_background.json',
                                            height:80,
                                            width: 80,
                                          )),
                                      Text("Metro " + metros[index].metro_num,style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),)
                                    ],
                                  ),


                                ),
                                onTap:(){
                                  // LatLng Metroposition = getCurrentLatLngFromSharedPrefs();
                                  // LatLng destinationLatLng = getTripLatLngFromSharedPrefs('destination');
                                  // Map modifiedResponse =
                                  //     await getDirectionsAPIResponse(sourceLatLng, destinationLatLng);
                                  //
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (_) =>
                                  //             ReviewRide(modifiedResponse: modifiedResponse)));
                                }
                            ),
                          ],
                        );  }

                    ),
                  ),

                ],
              )
              ),
              SizedBox(height: 150,)

            ],
          ),
        ),
      ),
      floatingActionButton: //reviewRideFaButton(context,sourceController.text,destinationController.text),
      FloatingActionButton.extended(
          icon: const Icon(Icons.train),
          onPressed: () async {
              setState(() {
              visibility=true ;
              metros = find_stations( sourceController.text, destinationController.text);
              print(metros);
          },

              );},
    label: const Text('Show Rides')
    )
    );
  }
}