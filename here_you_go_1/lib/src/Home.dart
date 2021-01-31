import 'package:flutter/material.dart';
import 'package:here_you_go_1/src/expenses.dart';
final String appTitle = "Expense App";

void main() {
  runApp(Home());
}

class Home extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: appTitle,
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Expense(),
        debugShowCheckedModeBanner: false);
  }
}