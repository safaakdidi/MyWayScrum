import 'package:flutter/material.dart';
import 'package:googleads/data/staions_list1.dart';
import 'package:googleads/helpers/map-box_handler.dart';
import 'package:googleads/screens/mapBox/review_ride.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:collection/collection.dart';
import '../helpers/shared_prefs.dart';

Widget reviewRideFaButton(BuildContext context,String source,String destination) {
  return FloatingActionButton.extended(
      icon: const Icon(Icons.train),
      onPressed: () async {
        LatLng sourceLatLng = getTripLatLngFromSharedPrefs('source');
        LatLng destinationLatLng = getTripLatLngFromSharedPrefs('destination');
        Map modifiedResponse =
        await getDirectionsAPIResponse(sourceLatLng, destinationLatLng);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    ReviewRide(modifiedResponse: modifiedResponse)));
      },
      label: const Text('Review Ride'));
}