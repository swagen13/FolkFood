import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:folkfood/utility/my_style.dart';
import 'package:folkfood/utility/normal_dialog.dart';
import 'dart:convert';
import 'package:folkfood/model/user_model.dart';
import 'package:folkfood/screens/main_user.dart';
import 'package:folkfood/screens/main_shop.dart';
import 'package:folkfood/screens/main_rider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // Field
  String user = " ";
  String password = " ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Container(
        decoration: BoxDecoration(
            // gradient: RadialGradient(
            //   colors: <Color>[Colors.white, MyStyle().primaryColor],
            //   center: Alignment(0, -0.3),
            //   radius: 1,
            // ),
            ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                MyStyle().showLogo(),
                MyStyle().showTitle('Folk Food'),
                MyStyle().mySizebox(),
                userForm(),
                MyStyle().mySizebox(),
                passwordForm(),
                MyStyle().mySizebox(),
                loginButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget loginButton() {
    return Container(
      width: 250,
      child: RaisedButton(
        color: Colors.brown,
        onPressed: () {
          if (user == 'null' ||
              user.isEmpty ||
              password == 'null' ||
              password.isEmpty) {
            normalDialog(context, 'มีช่องว่าง กรุณากรอกให้ครบค่ะ');
          } else {
            checkAuthen();
          }
        },
        child: Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Future<Null> checkAuthen() async {
    String url = 'http://10.0.2.2/php/checkUser.php?isAdd=true&user=$user';
    try {
      Response response = await Dio().get(url);
      var result = json.decode(response.data);
      for (var map in result) {
        UserModel userModel = UserModel.fromJson(map);
        if (password == userModel.password) {
          String? chooseType = userModel.chooseType;
          if (chooseType == 'User') {
            routeTuService(MainUser(), userModel);
          } else if (chooseType == 'Shop') {
            routeTuService(MainShop(), userModel);
          } else if (chooseType == 'Rider') {
            routeTuService(MainRider(), userModel);
          } else {
            normalDialog(context, 'Error');
          }
        } else {
          normalDialog(context, 'Password ผิด กรุณาลองใหม่');
        }
      }
    } catch (e) {}
  }

  Future<Null> routeTuService(Widget myWidget, UserModel userModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('id', userModel.id.toString());
    prefs.setString('chooseType', userModel.chooseType.toString());
    prefs.setString('name', userModel.name.toString());

    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  Widget userForm() => Container(
        width: 250,
        child: TextField(
          onChanged: (value) => user = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: Colors.brown,
            ),
            labelStyle: TextStyle(color: Colors.brown),
            labelText: 'User : ',
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyStyle().primaryColor)),
          ),
        ),
      );

  Widget passwordForm() => Container(
        width: 250,
        child: TextField(
          onChanged: (value) => password = value.trim(),
          //star text
          obscureText: true,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.brown,
            ),
            labelStyle: TextStyle(color: Colors.brown),
            labelText: 'Password : ',
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyStyle().primaryColor)),
          ),
        ),
      );
}
