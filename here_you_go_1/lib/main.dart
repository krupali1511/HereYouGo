import 'package:flutter/material.dart';

import 'package:here_you_go_1/screens/view_blog_screen.dart';
import 'package:here_you_go_1/src/expenses.dart';
import 'package:here_you_go_1/src/category_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'src/expenses.dart';

=======
import 'package:here_you_go_1/services/auth.dart';
import 'package:here_you_go_1/src/wrapper.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';
final String appTitle = "Expense App";
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: appTitle,
        theme: ThemeData(
          primarySwatch: Colors.green,
          //visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        //home: Expense(),
        home: Scaffold(
          body: Row(
            children: <Widget>[
              Expanded(
                child: RaisedButton(
                  child: Text('Expense'),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder:(context)=>Expense()));
                  },
                  color: Colors.blue,
                ),
              ),
              Expanded(
                child: RaisedButton(
                  child: Text('Blog'),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder:(context)=>ViewBlog()));
                  },
                  color: Colors.blue,
                ),
              )
            ],
          ),
        ),
        debugShowCheckedModeBanner: false);
=======
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
