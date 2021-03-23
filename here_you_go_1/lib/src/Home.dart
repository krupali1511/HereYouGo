import 'package:flutter/material.dart';
import 'package:here_you_go_1/Screens/add_blog_screen.dart';
import 'package:here_you_go_1/Screens/view_blog_screen.dart';
import 'package:here_you_go_1/services/auth.dart';
import 'package:here_you_go_1/sidebar/sidebar_layout.dart';
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
  final AuthService _auth = AuthService();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Home',
      theme: new ThemeData(
      ),
      debugShowCheckedModeBanner: false,
      home: SideBarLayout(),
    );
  }
}