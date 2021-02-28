import 'package:flutter/material.dart';
import 'package:here_you_go_1/navdrawer/menu_page.dart';
import 'package:here_you_go_1/navdrawer/zoom_scaffold.dart';
import 'package:here_you_go_1/services/ProfilePage.dart';
import 'package:here_you_go_1/Screens/add_blog_screen.dart';
import 'package:here_you_go_1/Screens/view_blog_screen.dart';
import 'package:here_you_go_1/services/auth.dart';
import 'package:here_you_go_1/src/expenses.dart';
import 'package:here_you_go_1/src/login.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
final String appTitle = "Expense App";

void main() {
  runApp(Home());
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin{
  MenuController menuController;
  final AuthService _auth = AuthService();
  @override
  void initState() {
    super.initState();

    menuController = new MenuController(
      vsync: this,
    )..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    menuController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Zoom Menu',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Drawer(
      child: Container(
      color: backcolor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
                color: appbarc,
                image: DecorationImage(
                    image: AssetImage("images/flame-web-security.png"),
                    fit: BoxFit.cover)),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilePage()));
            },
            leading: Icon(
              Icons.account_circle,
              color: Colors.black,
            ),
            title: Text(
              'User',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Expenses()));
            },
            leading: Icon(
              Icons.money,
              color: Colors.black,
            ),
            title: Text(
              'Expense',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddBlog()));
            },
            leading: Icon(
              Icons.list,
              color: Colors.black,
            ),
            title: Text(
              'Add Blog',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddBlog()));
            },
            leading: Icon(
              Icons.recent_actors,
              color: Colors.black,
            ),
            title: Text(
              'References',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            onTap: () async {
              await _auth.signOut();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Login()));
            },
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.black,
            ),
            title: Text(
              'Logout',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    ),
    ),
    );
  }
}