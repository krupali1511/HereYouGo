import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FireBaseAPI {
  String userid="";
  static Stream<QuerySnapshot> TripStream;
  static CollectionReference reference;

  FireBaseAPI(){
    TripStream = Firestore.instance.collection('trip').snapshots();
    reference = Firestore.instance.collection('trip');
  }
  getcurrentUser(BuildContext context) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    userid = user.uid.toString();
  }

  static addTrip(String name, String source, String scountry, String sstate, String destination, String dcountry, String dstate, String modesoftransportation,
  String date, TimeOfDay time,) {
    Firestore.instance.runTransaction((Transaction transaction) async {
      await reference.add({
        "name": name,
        "scountry": scountry,
        "sstate": sstate,
        "destination": destination,
        "dcountry": dcountry,
        "dstate": dstate,
        "modesoftransportation": modesoftransportation,
        "date": date,
        "time": time,
      });
    });
  }

  static removeTrip(String id) {
    Firestore.instance.runTransaction((Transaction transaction) async {
      await reference.document(id).delete().catchError((error) {
        print(error);
      });
    });
  }

  static updateTrip(String id, String newName,String source, String scountry, String sstate, String destination, String dcountry, String dstate, String modesoftransportation,
      DateTime date, TimeOfDay time,) {
    Firestore.instance.runTransaction((Transaction transaction) async {
      await reference.document(id).updateData({
        "name": newName,
        "scountry": scountry,
        "sstate": sstate,
        "destination": destination,
        "dcountry": dcountry,
        "dstate": dstate,
        "modesoftransportation": modesoftransportation,
        "date": date,
        "time": time,
      }).catchError((error) {
        print(error);
      });
    });
  }
}