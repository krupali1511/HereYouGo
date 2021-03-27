import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:here_you_go_1/Screens/TripDetails.dart';
import 'package:here_you_go_1/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:here_you_go_1/models/tripModel.dart';
<<<<<<< HEAD
import 'package:here_you_go_1/services/TripApi.dart';
String imagePath;
String name;
class MyTripsPage extends StatelessWidget with NavigationStates{
=======
import 'package:here_you_go_1/services/SharedData.dart';

class MyTripsPage extends StatelessWidget with NavigationStates {
>>>>>>> 1f79553e5372dd9ef5e506f395adb6bbf2823a13
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
<<<<<<< HEAD
  String userid;

  final Map<String, AssetImage> images = {"Adventure": AssetImage("assets/images/adventure.jpg"),
    "Roadtrip": AssetImage("assets/images/roadtrip.jpg"),
    "Religious": AssetImage("assets/images/religious.jpg"),"Family": AssetImage("assets/images/family.jpg"),
    "Single": AssetImage("assets/images/single.jpg"),"Group": AssetImage("assets/images/group.jpg"),};
=======
  SharedData sd = new SharedData();
>>>>>>> 1f79553e5372dd9ef5e506f395adb6bbf2823a13

  Widget buildBody(BuildContext context) {
   return StreamBuilder<QuerySnapshot>(

<<<<<<< HEAD
     stream: getUserTrip(),
     builder: (context, snapshot) {
       if (snapshot.hasError) {
         print('hellooooo');
         return Text('Error ${snapshot.error}');
       }
       if (snapshot.hasData) {
         //print("Documents ${snapshot.data.documents.length}");
         return buildList(context, snapshot.data.documents);
       }
       return CircularProgressIndicator();
     },
   );
=======
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
>>>>>>> 1f79553e5372dd9ef5e506f395adb6bbf2823a13
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
    name=tripModel.name.toString();
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
                        Text(tripModel.source.toString()+'-'+tripModel.destination.toString(),style: TextStyle(color:Colors.white), ),
                        Row(
                          children: <Widget>[

                            Text(tripModel.modesoftransportation.toString(),style: TextStyle(color:Colors.white))
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
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: tripModel.catvalue.toString()== null ? images["wind"] : images[tripModel.catvalue],
                  ),
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
        title: Text("Trips",style: TextStyle(color: Colors.white),),
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
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TripDetails()));
          },
          label: Text("add")),
    );

  }

  deleteTrip(trip tripModel){
    Firestore.instance.runTransaction(
          (Transaction transaction) async {
        await transaction.delete(tripModel.reference);
      },
    );
  }
  getUser() async {
    String userId = ( await FirebaseAuth.instance.currentUser()).uid;
    userid = userId;
  }

  getUserTrip()  {
    getUser();
    return Firestore.instance.collection('trip').document(userid).collection(name).snapshots();

  }

}
