import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:here_you_go_1/Screens/Trip.dart';
import 'package:here_you_go_1/bloc.navigation_bloc/navigation_bloc.dart';

class MyTripsPage extends StatelessWidget with NavigationStates {
  @override
  Widget build(BuildContext context) {
    return MyTrips();
  }
}

class MyTrips extends StatefulWidget {

  @override
  _MyTripsState createState() => _MyTripsState();
}

class _MyTripsState extends State<MyTrips> {
  dynamic data;

  getData() async {
    String userId = ( await FirebaseAuth.instance.currentUser()).uid;
    print(userId);
    final DocumentReference document =   Firestore.instance.collection('trip').document(userId).collection('trips').document();

    await document.get().then<dynamic>(( DocumentSnapshot snapshot) async{
      setState(() {
        data =snapshot.data;
        print(data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Text("screen"),
          ),

        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Trip()));
        },
        label: Text('Add',
            style: TextStyle(color:Colors.white)),
        icon: Icon(Icons.add, color:Colors.white),
        backgroundColor: Colors.black87,
      ),

    );
  }

}
