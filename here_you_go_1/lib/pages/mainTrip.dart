import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:here_you_go_1/pages/category.dart';
import 'package:here_you_go_1/pages/myexpensepage.dart';
import '../bloc.navigation_bloc/navigation_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:here_you_go_1/models/usertrip_model.dart';

import 'MyBlogPage.dart';
import 'subtripspage.dart';

class Usertrip extends StatefulWidget with NavigationStates{
  const Usertrip({Key key}) : super(key: key);

  @override
  _UsertripState createState() => _UsertripState();
}

class _UsertripState extends State<Usertrip> {
  static String userid="";
  String collection = "usertrip";


  bool isExpenseLoaded = false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();

  getUser() async {
    String userId = ( await FirebaseAuth.instance.currentUser()).uid;
    userid = userId;
  }
  getTrip() {
    getUser();
    print(userid);
    return Firestore.instance.collection(collection).where("uid", isEqualTo: userid).snapshots();
  }

  final Map<String, AssetImage> images = {"Adventure": AssetImage("assets/images/adventure.png"),
    "Roadtrip": AssetImage("assets/images/roadtrip.png"),
    "Religious": AssetImage("assets/images/temple.png"),"Family": AssetImage("assets/images/family.png"),
    "Single": AssetImage("assets/images/single.png"),"Group": AssetImage("assets/images/group.png"),};


  Widget buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: getTrip(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print('hellooooo');
          return Text('Error ${snapshot.error}');
        }
        if(!snapshot.hasData){
          return Center(child: Text("Add your next trip path",style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.bold,fontSize: 28),));
        }
        if (snapshot.hasData) {
          //print("Documents ${snapshot.data.documents.length}");
          print(userid);
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
    final userTripModel=UserTripModel.fromSnapshot(data);
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
                width: 300.0,
                height: 115.0,
                child: Card(
                    color: Colors.black87,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>MyTrips(trip: userTripModel.name,)));
                    },

                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      bottom: 8.0,
                      left: 44.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment:
                      MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(userTripModel.name.toUpperCase(),style: GoogleFonts.playfairDisplay(color:Colors.white,fontSize: 20,), ),
                        Row(
                          children: <Widget>[
                            new FlatButton(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Icon(Icons.add, size: 18,color: Colors.white,),
                                    ),
                                    TextSpan(
                                      text: "Add Expense ",
                                    ),

                                  ],
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(context,MaterialPageRoute(builder: (context)=>Expense(tripName:userTripModel.name,)));
                              },
                            ),
                            new FlatButton(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Icon(Icons.add, size: 18,color: Colors.white,),
                                    ),
                                    TextSpan(
                                      text: "Add Blog ",
                                    ),

                                  ],
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(context,MaterialPageRoute(builder: (context)=>ViewBlog(tripName:userTripModel.name,)));
                              },
                            ),
                          ],
                        )

                      ],
                    ),
                  ),)
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
                   image: userTripModel.category.toString()== null ? images["wind"] : images[userTripModel.category],
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
  Future<void> initState()  {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
     getUser();
    print("init");
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left:20.0),
          child: Text('     My Trips', style: TextStyle(color: Colors.white),),
        ),
        backgroundColor: Colors.black87,
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () async {
          if(!isExpenseLoaded)
          return null;
        },
        child: Container(
          margin: EdgeInsets.only(left: 12.0),
          child: Column(
            children: [
              Flexible(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: buildBody(context),
              )),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Navigator.push(context,MaterialPageRoute(builder: (context)=>Category()));

        },
        label: Text('Add',
            style: TextStyle(color:Colors.white)),
        icon: Icon(Icons.add, color:Colors.white),
        backgroundColor: Colors.black87,
      ),
    );
  }

}
