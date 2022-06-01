
import 'package:flutter/material.dart';
import 'package:googleads/admin/admin_metro.dart';
import 'package:googleads/screens/authenticate/sign_in.dart';
import 'package:googleads/screens/mapBox/Current_pos_config.dart';
import 'package:googleads/screens/mapBox/MapboxPos.dart';
import 'package:googleads/screens/mapBox/prepare_ride.dart';
import 'package:googleads/services/geolocator_service.dart';
import 'package:googleads/wrapper.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';


late SharedPreferences sharedPreferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    sharedPreferences = await SharedPreferences.getInstance();

  await Firebase.initializeApp(
    name: 'name-here',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: "assets/config/.env");

  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  Color _primaryColor = HexColor('#80FF72');
  Color _accentColor = HexColor('#7EE8FA') ;
  final geoService = GeolocatorService();

  // This widget is the root of your application.


  @override
  Widget build(BuildContext context) {
    return FutureProvider(
      create: (context) => geoService.getInitialLocation(),
      initialData: null,
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primaryColor: _primaryColor,
            accentColor: _accentColor ,
            scaffoldBackgroundColor : Colors.grey.shade100 ,
            primarySwatch: Colors.grey ,

          ),

          home:Wrapper(title: '',)
      ),
    );
  }
}
