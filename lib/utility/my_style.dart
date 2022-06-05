import 'package:flutter/material.dart';

class MyStyle {
  //Color
  Color darkColor = Colors.blue.shade900;
  Color primaryColor = Colors.brown;

  TextStyle mainTitle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: Colors.purple,
  );

  TextStyle mainH2Title = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    color: Colors.green.shade700,
  );

  //Sizebox
  SizedBox mySizebox() => SizedBox(width: 8.0, height: 11.0);

  //Show Title
  Text showTitle(String title) => Text(title,
      style: TextStyle(
          fontSize: 24,
          color: Colors.blue.shade900,
          fontWeight: FontWeight.bold));

  Widget titleCenter(BuildContext context, String string) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Text(
          string,
          style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade400),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  //Show Title H2
  Text showTitleH2(String title) => Text(title,
      style: TextStyle(
          fontSize: 18,
          color: Colors.blue.shade900,
          fontWeight: FontWeight.bold));

  //Show Logo
  Container showLogo() {
    return Container(
      width: 120.0,
      child: Image.asset('images/logo.png'),
    );
  }

  BoxDecoration myBoxDecoration(String namePic) {
    return BoxDecoration(
        image: DecorationImage(
      image: AssetImage('images/$namePic'),
      fit: BoxFit.cover,
    ));
  }

  MyStyle();
}
