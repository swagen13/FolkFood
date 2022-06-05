import 'package:flutter/material.dart';
import 'package:folkfood/screens/home.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.brown),
      title: 'FOlk Food',
      home: Home(),
    );
  }
}
