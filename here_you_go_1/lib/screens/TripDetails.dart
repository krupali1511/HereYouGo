import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:here_you_go_1/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:here_you_go_1/models/tripModel.dart';
import 'package:date_format/date_format.dart';
import 'package:here_you_go_1/pages/subtripspage.dart';
import 'package:intl/intl.dart';

String countryValue, stateValue,cityValue,dcountryValue,dstateValue,dcityValue,motValue;

class TripDetails extends StatefulWidget with NavigationStates{
  final String name;
  final String docId;
  final String tripName;

  TripDetails({this.name, this.docId, this.tripName,});
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

  double _height;
  double _width;

  String _setTime, _setDate;

  String _hour, _minute, _time;

  String dateTime;

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
  }

  @override
  void initState() {
    _dateController.text = DateFormat.yMd().format(DateTime.now());

    _timeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
    super.initState();
  }


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
                    SizedBox(height: 10.0),
                    SizedBox(height: 20,),
                    Text('Source', style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold,),),
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
                    Text(
                      'Select Date',
                      style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold,),
                    ),
                    InkWell(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.only(left: 10.0, right: 10.0),
                        alignment: Alignment.center,
                        child: TextFormField(
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                          enabled: false,
                          keyboardType: TextInputType.text,
                          controller: _dateController,
                          onSaved: (String val) {
                            _setDate = val;
                          },
                          decoration: InputDecoration(
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                              ),
                              filled: true,
                              hintStyle: new TextStyle(color: Colors.grey[200]),
                              hintText: "Date",
                              fillColor: Colors.white70),
                          // disabledBorder:
                          // UnderlineInputBorder(borderSide: BorderSide.none),
                          // labelText: 'Time',
                          // contentPadding: EdgeInsets.only(top: 0.0)),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      'Select Time',
                      style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold,),
                    ),
                    InkWell(
                      onTap: () {
                        _selectTime(context);
                      },
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.only(left: 10.0, right: 10.0),
                        alignment: Alignment.center,
                        child: TextFormField(
                          style: TextStyle(fontSize: 20,),
                          textAlign: TextAlign.center,
                          onSaved: (String val) {
                            _setTime = val;
                          },
                          enabled: false,
                          keyboardType: TextInputType.text,
                          controller: _timeController,
                          decoration: InputDecoration(
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                              ),
                              filled: true,
                              hintStyle: new TextStyle(color: Colors.grey[200]),
                              hintText: "Time",
                              fillColor: Colors.white70),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text('Mode Of Transport', style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold,),),
                    DropdownButtonHideUnderline(
                        child: Container(
                          width: 400,
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
                          side: BorderSide(color: Colors.black)
                      ),
                      color: Colors.black,
                      textColor: Colors.white,
                      padding: EdgeInsets.all(8.0),
                      onPressed: () {AddData();

                      },
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

  Future AddData() {
    trip tr = trip(
      uid: userid,
      scountry: countryValue,
      sstate: stateValue,
      source: cityValue,
      modesoftransportation: motValue,
      dcountry:dcountryValue,
      dstate:dstateValue,
      destination:dcityValue,
      date:_dateController.text,
      time:_timeController.text,
    );
    try {
      print(widget.tripName);
      Firestore
          .instance
          .collection('trip')
          .document(userid)
          .collection(widget.tripName)
          .add(tr.toJson(),
      );
      print('Data Added');
    } catch (e) {
      print(e.toString());
    }
  }

}

