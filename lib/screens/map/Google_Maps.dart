
import 'package:flutter/material.dart';
import 'package:googleads/Layout/footer.dart';
import 'package:googleads/screens/map/MapSample.dart';
import 'package:latlong2/latlong.dart' as lating;
import 'package:flutter_map/flutter_map.dart';

class Google_Maps extends StatefulWidget {
  const Google_Maps({Key? key}) : super(key: key);

  @override
  State<Google_Maps> createState() => _Google_MapsState();
}

class _Google_MapsState extends State<Google_Maps> {
  @override
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


                      ))
                ],
              )
          )
        ],
      ),
      body:  Stack(
        children: <Widget>[
          new Container(
          child: MapSample()
    )


          ,Footer()
        ],
      ),
    );
  }
}