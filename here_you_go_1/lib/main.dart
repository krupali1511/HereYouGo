import 'package:flutter/material.dart';
import 'package:here_you_go_1/src/expense.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


Future<void> main() async {

  runApp(Demo());
}

class Demo extends StatelessWidget{
  @override
  Widget build(BuildContext context){
  Map data;
  getAmount(){
      Map<String,dynamic> demodata = {"note": "note about expense","amount": 20.44};
      CollectionReference dataref = Firestore.instance.collection('expense');
      dataref.add(demodata);
    }
    return MaterialApp(
      home: Scaffold(
        body: Center(child: Text("Expenses"),),
        floatingActionButton: FloatingActionButton(
          onPressed: getAmount(),
          child: Icon(Icons.add),
          backgroundColor: Colors.blueAccent,
        ),
      ),
    );
  }
}

