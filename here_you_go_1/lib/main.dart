import 'package:flutter/material.dart';
import 'package:here_you_go_1/pages/mytripspage.dart';
import 'package:here_you_go_1/services/auth.dart';
import 'package:here_you_go_1/src/wrapper.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';
final String appTitle = "Expense App";
void main() => runApp(MyApp());

 class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}

/*class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: MyTrip(),
        );
  }*/


