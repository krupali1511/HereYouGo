import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:here_you_go_1/Screens/TripDetails.dart';
import 'package:here_you_go_1/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:here_you_go_1/models/tripModel.dart';
import 'package:here_you_go_1/services/SharedData.dart';

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
  SharedData sd = new SharedData();

  deleteTrip(trip tripModel){
    Firestore.instance.runTransaction(
          (Transaction transaction) async {
        await transaction.delete(tripModel.reference);
      },
    );
  }
  Widget buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(

      stream: sd.getUserTrip(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error ${snapshot.error}');
        }
        if (snapshot.hasData) {
          //print("Documents ${snapshot.data.documents.length}");
          return buildList(context, snapshot.data.documents);
        }

        return CircularProgressIndicator();
      },
    );
  }
  Widget buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: snapshot.map((data) => buildListItem(context, data)).toList(),
    );
  }
  Widget buildListItem(BuildContext context, DocumentSnapshot data) {
    final tripModel = trip.fromSnapshot(data);
    return Padding(
      key: ValueKey(data.reference.documentID),
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.0),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile(
          title: Text(tripModel.name.toString()),
          subtitle: Text(tripModel.catvalue),
          trailing: IconButton(
            icon: Icon(Icons.delete,color: Colors.black,),
            onPressed: () {
              // delete
              deleteTrip(tripModel);
            },
          ),
          onTap: () async {

          },

        ),


      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Trips",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
      ),
     body: SingleChildScrollView(
       child: Container(
          child:buildBody(context) ,
        ),
     ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TripDetails()));
          },
          label: Text("add")),
    );
  }

}
