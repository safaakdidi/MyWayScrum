import 'dart:convert';

import 'package:flutter/material.dart';

import '../main.dart';

Widget searchListView(
    List<String> responses,
    bool isResponseForDestination,
    TextEditingController destinationController,
    TextEditingController sourceController) {
  return ListView.builder(
    shrinkWrap: true,
   // physics: const NeverScrollableScrollPhysics(),
    itemCount: responses.length,
    itemBuilder: (BuildContext context, int index) {
      return Column(
        children: [
          ListTile(
            onTap: () {
              String text = responses[index];
              if (isResponseForDestination) {
                destinationController.text = text;
                // sharedPreferences.setString(
                //     'destination', responses[index]);
                // print("desssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss");
                // print(sharedPreferences.getString('destination')!);
              } else {
                sourceController.text = text;
                // sharedPreferences.setString(
                //     'source', responses[index]);
                // print(sharedPreferences.getString('source')!);
              }
              FocusManager.instance.primaryFocus?.unfocus();
            },
            leading: const SizedBox(
              height: double.infinity,
              child: CircleAvatar(child: Icon(Icons.map)),
            ),
            title: Text(responses[index],
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(responses[index],
                overflow: TextOverflow.ellipsis),
          ),
          const Divider(),
        ],
      );
    },
  );
}