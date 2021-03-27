import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:here_you_go_1/models/tripModel.dart';

class SharedData {
  String userid="";
  SharedData(){}


  getUser() async {
    String userId = ( await FirebaseAuth.instance.currentUser()).uid;
    userid = userId;
  }

  getUserTrip(){
    getUser();
    return Firestore.instance.collection('trip').where('uid',isEqualTo: userid).snapshots();

  }

  deleteTrip(trip tripModel){
    Firestore.instance.runTransaction(
          (Transaction transaction) async {
        await transaction.delete(tripModel.reference);
      },
    );
  }
}