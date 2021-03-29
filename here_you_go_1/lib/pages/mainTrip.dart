import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:here_you_go_1/pages/myexpensepage.dart';
import '../bloc.navigation_bloc/navigation_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:here_you_go_1/models/usertrip_model.dart';

import 'MyBlogPage.dart';
import 'mytripspage.dart';

class Usertrip extends StatefulWidget with NavigationStates{
  const Usertrip({Key key}) : super(key: key);

  @override
  _UsertripState createState() => _UsertripState();
}

class _UsertripState extends State<Usertrip> {
  static String userid="";
  String title = "MyTrips";
  String category;
  String collection = "usertrip";
  TextEditingController tripNameCont = new TextEditingController();

  bool isExpenseLoaded = false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();

  getUser() async {
    String userId = ( await FirebaseAuth.instance.currentUser()).uid;
    userid = userId;
  }
  getTrip() {
    print(userid);
    return Firestore.instance.collection(collection).where("uid", isEqualTo: userid).snapshots();
  }
  generateTripCollection(){

    UserTripModel usertrip =  UserTripModel(name: tripNameCont.text, uid: userid,category: category);
    try {
      //generating empty sub-collection into "trip" collection
      Firestore.instance.collection('trip').document(userid).collection(tripNameCont.text).snapshots();
      // adding trip name, category, uid to "usertrip" collection
      Firestore.instance.runTransaction(
            (Transaction transaction) async {
          await Firestore.instance
              .collection(collection)
              .document()
              .setData(usertrip.toJson());
        },
      );

    } catch (e) {
      print(e.toString());
    }
  }

  Widget buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: getTrip(),
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
    final userTripModel = UserTripModel.fromSnapshot(data);
    return Padding(
      key: ValueKey(data.reference.documentID),
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        child:InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => MyTrips(tripName:userTripModel.name,)));
          },
          child: Card(
            color: Colors.black87,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                bottom: 8.0,
                left: 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment:
                MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(userTripModel.name.toUpperCase(),style: GoogleFonts.playfairDisplay(color:Colors.white,fontSize: 24,), ),
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
            ),
          ),
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
          child: Text(title, style: TextStyle(color: Colors.white),),
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
          await Alert(
              context: context,
              title: "Add Trip",
              content: Column(
                children: <Widget>[
                  TextField(
                    controller: tripNameCont,
                    decoration: InputDecoration(
                      icon: Icon(Icons.book,color: Colors.black,),
                      labelText: 'Trip Name',
                    ),
                  ),
                  DropdownButton<String>(
                    value: category,
                    icon: const Icon(Icons.arrow_downward,color: Colors.black,),
                    iconSize: 24,
                    elevation: 16,
                    style: GoogleFonts.lato(color: Colors.black,fontSize: 24),
                    underline: Container(
                      height: 2,
                      color: Colors.black,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        category = newValue;
                      });
                    },
                    items: <String>['Adventure',
                      'Roadtrip',
                      'Religious',
                      'Family',
                      'Single',
                      'Group']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              buttons: [
                DialogButton(
                  onPressed: () async {
                    await generateTripCollection();
                    tripNameCont.clear();
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  child: Text(
                    "Add",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              ]).show();
        },
        label: Text('Add',
            style: TextStyle(color:Colors.white)),
        icon: Icon(Icons.add, color:Colors.white),
        backgroundColor: Colors.black87,
      ),
    );
  }

}
