import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SharedData {
  String userid;
 // List<String>
  getUser() async {
    String userId = (await FirebaseAuth.instance.currentUser()).uid;
    userid = userId;
    return userid;
  }
  getUserTrip() {
    getUser();
    return Firestore.instance
        .collection('trip')
        .where('uid', isEqualTo: userid)
        .snapshots();
  }
}
