import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:googleads/data/station_list.dart';
import 'package:googleads/screens/Metro_lines/polyline_wrapper.dart';
import 'package:googleads/screens/google_ads/googleAds.dart';
import 'package:googleads/screens/line_choice/metro_choiceV1.dart';
import 'package:googleads/screens/map/Google_Maps.dart';
import 'package:googleads/screens/mapBox/Current_pos_config.dart';
import 'package:googleads/screens/mapBox/MapboxPos.dart';
import 'package:googleads/screens/sign_up/profile_page.dart';
import 'package:googleads/testing_widgets/test.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:spincircle_bottom_bar/modals.dart';
import 'package:spincircle_bottom_bar/spincircle_bottom_bar.dart';

class Footer extends StatefulWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  Color _primaryColor = HexColor('#80FF72');
  Color _accentColor = HexColor('#7EE8FA');
  @override
  Widget build(BuildContext context) {
    return Container(
      child : SpinCircleBottomBarHolder(
             bottomNavigationBar: SCBottomBarDetails(
            iconTheme:IconThemeData(color:Colors.white),
            activeIconTheme: IconThemeData(color: Colors.white),
            titleStyle: TextStyle(color: Colors.white , fontSize: 12) ,
            activeTitleStyle: TextStyle(color: Colors.white,fontSize: 12, fontWeight: FontWeight.bold),
            actionButtonDetails: SCActionButtonDetails(color: Colors.green, icon: Icon(Icons.train_outlined),elevation: 10),
            backgroundColor:_accentColor,
            circleColors: [Colors.white, Color(0xD71F9BD2),Colors.green] ,
            bnbHeight: 60,



            items:<SCBottomBarItem>[
          SCBottomBarItem(icon: Icons.map_sharp , onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) =>MapPos()));

          },title: "Map"),
          SCBottomBarItem(icon:Icons.location_pin, onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Metro_choice()));

          },title: "Lignes"),

          SCBottomBarItem(icon:Icons.attach_money, onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => GoogleAds()));
          },title: "Internet"),
          SCBottomBarItem(icon:Icons.person, onPressed: (){

            Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));

          },title: "Profile")

,
        ],
            circleItems:<SCItem>[
          SCItem(icon: Icon(Icons.help_outline), onPressed: (){}) ,

          SCItem(icon: Icon(Icons.settings), onPressed: (){}) ,
              SCItem(icon: Icon(Icons.logout), onPressed: (){
                SystemNavigator.pop();

              }) ,

        ]
        ),
    child: Container(

    ),
      )
    );
  }
}
