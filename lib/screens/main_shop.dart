import 'package:flutter/material.dart';
import 'package:folkfood/utility/signout_process.dart';
import 'package:folkfood/widget/order_list_shop.dart';
import 'package:folkfood/widget/list_food_menu_shop.dart';
import 'package:folkfood/widget/infomation_shop.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:folkfood/utility/my_style.dart';

class MainShop extends StatefulWidget {
  @override
  State<MainShop> createState() => _MainShopState();
}

class _MainShopState extends State<MainShop> {
  // Field
  Widget currenWidget = OrderListShop();

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
        title: Text(nameUser == 'null' ? 'Main Shop' : 'Main Shop'),
        actions: <Widget>[
          IconButton(
              onPressed: () => signOutProcess(context),
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      drawer: showDrawer(),
      body: currenWidget,
    );
  }

  Drawer showDrawer() => Drawer(
        child: ListView(
          children: <Widget>[
            showHead(),
            homeMenu(),
            foodMenu(),
            infomationMenu(),
            signOutMenu()
          ],
        ),
      );

  ListTile homeMenu() => ListTile(
        leading: Icon(Icons.home, color: Colors.brown),
        title: Text('รายการอาหารที่ลูกค้าสั่ง'),
        subtitle: Text('รายการอาหารที่ยังไม่ได้ทำส่งลูกค้า'),
        onTap: () {
          setState(() {
            currenWidget = OrderListShop();
          });
          Navigator.pop(context);
        },
      );

  ListTile foodMenu() => ListTile(
        leading: Icon(Icons.fastfood, color: Colors.brown),
        title: Text('รายการอาหาร'),
        subtitle: Text('รายการอาหารทั้งหมดของร้าน'),
        onTap: () {
          setState(() {
            currenWidget = ListFoodMenuShop();
          });
          Navigator.pop(context);
        },
      );

  ListTile infomationMenu() => ListTile(
        leading: Icon(
          Icons.info,
          color: Colors.brown,
        ),
        title: Text('รายละเอียดของร้าน'),
        subtitle: Text('รายละเอียดของร้านค้า'),
        onTap: () {
          setState(() {
            currenWidget = InfomationShop();
          });
          Navigator.pop(context);
        },
      );

  ListTile signOutMenu() => ListTile(
        leading: Icon(Icons.exit_to_app, color: Colors.brown),
        title: Text('Sign Out'),
        subtitle: Text('Sing Out และกลับไปที่หน้าหลัก'),
        onTap: () => signOutProcess(context),
      );

  UserAccountsDrawerHeader showHead() {
    return UserAccountsDrawerHeader(
        decoration: MyStyle().myBoxDecoration('user.jpg'),
        currentAccountPicture: MyStyle().showLogo(),
        accountName: Text(
          'Name Shop',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        accountEmail: Text(
          'Login',
          style: TextStyle(fontWeight: FontWeight.bold),
        ));
  }
}
