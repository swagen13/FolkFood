import 'package:flutter/material.dart';
import 'package:folkfood/utility/signout_process.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:folkfood/utility/my_style.dart';

class MainRider extends StatefulWidget {
  @override
  State<MainRider> createState() => _MainRiderState();
}

class _MainRiderState extends State<MainRider> {
  String? nameUser;

  void initState() {
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nameUser = prefs.getString('name');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nameUser == 'null' ? 'Main Rider' : '$nameUser'),
        actions: <Widget>[
          IconButton(
              onPressed: () => signOutProcess(context),
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      drawer: showDrawer(),
    );
  }

  Drawer showDrawer() => Drawer(
        child: ListView(
          children: <Widget>[showHeaderDrawer()],
        ),
      );

  UserAccountsDrawerHeader showHeaderDrawer() {
    return UserAccountsDrawerHeader(
        decoration: MyStyle().myBoxDecoration('rider.jpg'),
        currentAccountPicture: MyStyle().showLogo(),
        accountName: Text(
          '$nameUser',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        accountEmail: Text(
          'Login',
          style: TextStyle(fontWeight: FontWeight.bold),
        ));
  }
}
