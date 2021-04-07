import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:here_you_go_1/models/usertrip_model.dart';
import 'package:here_you_go_1/screens/TripDetails.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'subtripspage.dart';


class Category extends StatelessWidget {
  String userid;
  String collection='trip';
  TextEditingController tripNameCont = new TextEditingController();
  String category;



  Items item1 = new Items(
      title: "Adventure",
      img: "assets/images/adventure.png");

  Items item2 = new Items(
      title: "Roadtrip",
      img: "assets/images/roadtrip.png");

  Items item3 = new Items(
      title: "Religious",
      img: "assets/images/temple.png");

  Items item4 = new Items(
      title: "Family",
      img: "assets/images/family.png");

  Items item5 = new Items(
      title: "Single",
      img: "assets/images/single.png");

  Items item6 = new Items(
      title: "Group",
      img: "assets/images/group.png");



  @override
  Widget build(BuildContext context) {

    List<Items> myList = [item1, item2, item3, item4, item5, item6];
    var color = 0xff453658;
    return Scaffold(
      appBar: AppBar(
        title: Text("Category",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
      ),
      body: GridView.count(
          childAspectRatio: 1.0,
          padding:EdgeInsets.all(18.0),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {
            return
              Container(
                  decoration: BoxDecoration(
                      color: Color(color), borderRadius: BorderRadius.circular(10)),
                  child: new InkWell(
                    onTap: () async { print(data.title);
                    category=data.title;
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
                      ],
                      ),
                      buttons: [
                      DialogButton(
                      onPressed: () async {
                      await generateTripCollection();
                     // Navigator.of(context, rootNavigator: true).pop();
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>MyTrips(trip: tripNameCont.text,)));
                      },
                      child: Text(
                      "Add",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      )
                      ]).show();
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          data.img,
                          width: 42,
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Text(
                          data.title,
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600)),
                        ),

                      ],
                    ),
                  ));
          }).toList()),

    );
  }
  getUser() async {
    String userId = ( await FirebaseAuth.instance.currentUser()).uid;
    userid = userId;
    print(userid);
    print('heloooooooooooooooooooooooooooooooooooo');
  }
  generateTripCollection() async {
    await getUser();
    print('hiii'+userid);
    UserTripModel usertrip =  UserTripModel(name: tripNameCont.text, uid: userid,category:category );
    try {

      // adding trip name, category, uid to "usertrip" collection
      Firestore.instance.runTransaction(
            (Transaction transaction) async {
          await Firestore.instance
              .collection('usertrip')
              .document()
              .setData(usertrip.toJson());
        },
      );

    } catch (e) {
      print(e.toString());
    }
  }
}

class Items {
  String title;
  String img;
  Items({this.title, this.img});
}
