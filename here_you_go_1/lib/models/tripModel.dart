import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'ExpenseModel.dart';

class trip {
  String uid;
  String name;
  String source;
  String scountry;
  String sstate;
  String destination;
  String dcountry;
  String dstate;
  String catvalue;
  String modesoftransportation;
  String date;
  String time;
  DocumentReference reference;

  trip(
      {this.name, this.source, this.scountry, this.sstate, this.destination, this.dcountry, this.dstate,this.modesoftransportation,this.date,this.time,this.catvalue,this.uid});

  trip.fromMap(Map<String, dynamic> map, {this.reference}){
    uid = map['uid'];
    name = map['name'];
    source = map['source'];
    scountry = map['scountry'];
    sstate = map['sstate'];
    destination = map['destination'];
    dcountry = map['dcountry'];
    dstate = map['dstate'];
    modesoftransportation = map['modesoftransportation'];
    date = map['date'];
    time = map['time'];
    catvalue = map['catvalue'];
  }

  trip.fromSnapshot(DocumentSnapshot snapshot) :
        this.fromMap(snapshot.data, reference: snapshot.reference);

  toJson() {
    return {
      'uid': uid,
      'name': name,
      'source': source,
      'scountry': scountry,
      'sstate': sstate,
      'destination': destination,
      'dcountry': dcountry,
      'dstate': dstate,
      'modesoftransportation': modesoftransportation,
      'date': date,
      'time': time,
      'catvalue' : catvalue,

    };
  }

}