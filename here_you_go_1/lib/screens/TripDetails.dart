import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:here_you_go_1/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:here_you_go_1/models/tripModel.dart';
import 'package:here_you_go_1/services/TripApi.dart';
import 'package:intl/intl.dart';
import 'Trip.dart';
String countryValue, stateValue,cityValue,dcountryValue,dstateValue,dcityValue,motValue,catValue;

class TripDetails extends StatefulWidget with NavigationStates{
  final String name;
  final String docId;


  TripDetails({this.name, this.docId});
  @override
  _TripDetailsState createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  final _formTripKey = GlobalKey<FormState>();
  String formattedDate = "";

  _TripDetailsState() {
    formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(selectedDate);
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
        'Trip', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,),),
        backgroundColor: Colors.black87,
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              AddData();
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Trip()));
            },
            child: Text(
              widget.name != null && widget.name.isNotEmpty ? "UPDATE" : 'SAVE',
              style: Theme
                  .of(context)
                  .textTheme
                  .subhead
                  .copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            child: ListView(
              children: <Widget>[
                SizedBox(height: 20,),
                Text('Source', style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold,),),
                new Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                          child: DropdownButtonHideUnderline(
                              child: Container(
                                width: 500,
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
                Text('Category', style: TextStyle(
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
                        value: catValue,
                        icon: Icon(Icons.arrow_drop_down),
                        onChanged: (String newValue) {
                          setState(() {
                            catValue = newValue;
                          });
                        },
                        hint: Text("Select Category"),
                        items: <String>[
                          'Adventure',
                          'Nature',
                          'Religious',
                          'Family',
                          'Couple'
                        ]
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

              ],)

        ),
      ),

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
      Firestore.instance.runTransaction(
            (Transaction transaction) async {
          await Firestore.instance
              .collection('trip')
              .document()
              .setData(tr.toJson());
        },
      );
      print('Data Added');
    } catch (e) {
      print(e.toString());
    }
  }
}
