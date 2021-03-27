import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:here_you_go_1/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:here_you_go_1/models/tripModel.dart';
import 'package:here_you_go_1/src/ProfilePage.dart';
import 'package:here_you_go_1/widgets/input_field.dart';
import 'package:intl/intl.dart';
String countryValue, stateValue,cityValue,dcountryValue,dstateValue,dcityValue,motValue,catValue;
final nameController=TextEditingController();

class TripDetails extends StatefulWidget with NavigationStates{
  final String name;
  final String docId;


  TripDetails({this.name, this.docId});
  @override
  _TripDetailsState createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  String formattedDate = "";
  String userid;
  getUser() async {
    String userId = ( await FirebaseAuth.instance.currentUser()).uid;
    userid = userId;
  }
  _TripDetailsState() {
    formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(selectedDate);
    getUser();
  }

  String validateName(String value) {
    if (value.isEmpty) {
      return "Please Enter  name.";
    } else {
      return null;
    }
  }

  DateTime selectedDate = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(title: Text(
        ' Add Trip', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,),),
        backgroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        child:Container(
        child:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                          child: DropdownButtonHideUnderline(
                              child: Container(
                                width: 100,
                                margin: EdgeInsets.only(left: 10.0,
                                    right: 10.0),
                                decoration: ShapeDecoration(
                                    color: Colors.grey.shade300,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)))
                                ),
                                child: SelectState(
                                  onCountryChanged: (value) {
                                    setState(() {
                                      countryValue = value;
                                    });
                                  },
                                  onStateChanged: (value) {
                                    setState(() {
                                      stateValue = value;
                                    });
                                  },
                                  onCityChanged: (value) {
                                    setState(() {
                                      cityValue = value;
                                    });
                                  },
                                ),))
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Destination', style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold,),),
                ),
                new Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                          child: DropdownButtonHideUnderline(
                              child: Container(
                                width: 300,
                                margin: EdgeInsets.only(left: 10.0,
                                    right: 10.0),
                                decoration: ShapeDecoration(
                                    color: Colors.grey.shade300,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)))
                                ),
                                child: SelectState(
                                  onCountryChanged: (value) {
                                    setState(() {
                                      dcountryValue = value;
                                    });
                                  },
                                  onStateChanged: (value) {
                                    setState(() {
                                      dstateValue = value;
                                    });
                                  },
                                  onCityChanged: (value) {
                                    setState(() {
                                      dcityValue = value;
                                    });
                                  },
                                ),))
                      ),

                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text("Select Date", style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold,),),

                RaisedButton(
                  onPressed: () => _selectDate(context),
                  child: Text(
                    'Pick Date',
                    style:
                    TextStyle(color: Colors.black,),
                  ),
                  color: Colors.grey.shade300,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                SizedBox(height: 20,),
                Text('Mode Of Transport', style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold,),),
                DropdownButtonHideUnderline(
                    child: Container(
                      width: 300,
                      margin: EdgeInsets.only(left: 10.0, right: 10.0),
                      decoration: ShapeDecoration(
                          color: Colors.grey.shade300,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10)))
                      ),
                      child: DropdownButton<String>(
                        value: motValue,
                        icon: Icon(Icons.arrow_drop_down),
                        onChanged: (String newValue) {
                          setState(() {
                            motValue = newValue;
                          });
                        },
                        hint: Text("Mode Of Transport"),
                        items: <String>['Airplane', 'Bus', 'Train', 'Other']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: EdgeInsets.only(left: 4),
                              child: Text(value),
                            ),);
                        }).toList(),
                      ),)
                ),
                SizedBox(height: 20,),
                 FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(color: Colors.blue)
                  ),
                  color: Colors.blue,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(8.0),
                  onPressed: () {AddData();},
                  child: Text(
                    "Add data",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),

              ],

        ),
      ),
    ))
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        print(selectedDate);
      });
  }

  Future AddData() {
    trip tr = trip(
      uid: userid,
      name:nameController.text,
      scountry: countryValue,
      sstate: stateValue,
      source: cityValue,
      modesoftransportation: motValue,
      catvalue: catValue,
      dcountry:dcountryValue,
      dstate:dstateValue,
      destination:dcityValue,
      date:formattedDate,
    );
    try {
      Firestore
          .instance
          .collection('trip')
          .document(userid)
          .collection('trips')
          .add(tr.toJson(),
      );
      print('Data Added');
    } catch (e) {
      print(e.toString());
    }
  }
}

