
/*
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:here_you_go_1/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:here_you_go_1/pages/mytripspage.dart';
import 'package:here_you_go_1/screens/TripDetails.dart';
import 'package:here_you_go_1/services/TripApi.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

final nameController=TextEditingController();

class Usertrip extends StatefulWidget with NavigationStates{
  @override
  _UsertripState createState() => _UsertripState();
}

class _UsertripState extends State<Usertrip> {
 // SharedData sd= new SharedData();
 // _UsertripState(){userid=sd.getUser();}
  String userid;

  final Map<String, AssetImage> images = {"Adventure": AssetImage("assets/images/adventure.jpg"),
    "Roadtrip": AssetImage("assets/images/roadtrip.jpg"),
    "Religious": AssetImage("assets/images/religious.jpg"),"Family": AssetImage("assets/images/family.jpg"),
    "Single": AssetImage("assets/images/single.jpg"),"Group": AssetImage("assets/images/group.jpg"),};
  @override
  Widget buildBody(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: getUserTrip(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print('hellooooo');
          return Text('Error ${snapshot.error}');
        }
        if (snapshot.hasData) {
          //print("Documents ${snapshot.data.documents.length}");
          return buildList(context, );
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
    return Padding(
      padding:
      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        height: 115,
        child: Stack(
          children: [
            Positioned(
              left: 50,
              child: Container(
                width: 290.0,
                height: 115.0,
                child: Card(
                  color: Colors.black87,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      bottom: 8.0,
                      left: 64.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment:
                      MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(data.data.toString(),style: TextStyle(color:Colors.white), ),
                        Row(
                          children: <Widget>[
                            new FlatButton(
                              child: const Text('Add Expense'),
                              onPressed: () { },
                            ),
                            new FlatButton(
                              child: const Text('Add Blog'),
                              onPressed: () {  },
                            ),
                          ],
                        )

                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 7.5,
              child: Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  //image: DecorationImage(
                  //  fit: BoxFit.cover,
                   // image: tripModel.catvalue.toString()== null ? images["wind"] : images[tripModel.catvalue],
                  //),
                ),
              ),
            ),
          ],
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
          backgroundColor: Colors.black87,
          onPressed: (){
            Alert(
                context: context,
                title: "Add",
                content: Column(
                  children: <Widget>[
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Trip Name',
                      ),
                    ),
                  ],
                ),
                buttons: [
                  DialogButton(
                    onPressed: ()  {
                      print('helooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo');
                      addTripname();
                      //await Firestore.instance.collection('usertrip').document(userid).setData({nameController.toString():nameController.toString()});
                      print('helooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo');
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>TripDetails()));
                      Navigator.pop(context);

                    },
                    child: Text(
                      "Add Trip Details",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )
                ]).show();
          },
          label: Text("Add Trip")),
    );
  }
  getUser() async {
    String userId = ( await FirebaseAuth.instance.currentUser()).uid;
    userid = userId;
  }
  getUserTrip(){
    getUser();
    return Firestore.instance.collection('usertrip').document(userid).snapshots();
  }

  addTripname() async {
    getUser();
    await Firestore.instance.collection('usertrip').add({nameController.text:nameController.text});
  }

} */
