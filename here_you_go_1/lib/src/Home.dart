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
      home: ChangeNotifierProvider.value(
        value: menuController,
        child: ZoomScaffold(
          menuScreen: MenuScreen(),
          contentScreen: Layout(
              contentBuilder: (cc) => Container(
                color: Colors.grey[200],
                child: Container(
                  color: Colors.grey[200],
                ),
              )),
        ),
      ),
    );
  }
}