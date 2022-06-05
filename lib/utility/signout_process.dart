import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:folkfood/screens/home.dart';

Future<Null> signOutProcess(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
  // exit(0);

  MaterialPageRoute route = MaterialPageRoute(
    builder: (context) => Home(),
  );
  Navigator.pushAndRemoveUntil(context, route, (route) => false);
}
