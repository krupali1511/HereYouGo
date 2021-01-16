import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Expense extends StatelessWidget{
  @override
  Widget build(BuildContext context){
      return MaterialApp(
        home: Scaffold(
          body: Center(child: Text("Expenses"),),
        ),
      );
  }
}