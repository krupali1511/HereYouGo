import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserTripModel{
  String name;
  String category;
  String uid;
  DocumentReference reference;

  UserTripModel({
    this.name,
    this.category,
    this.uid,
  });
  UserTripModel.fromMap(Map<String, dynamic> map, {this.reference}){
    name = map['name'];
    category = map['category'];
    uid = map['uid'];
  }
  UserTripModel.fromSnapshot(DocumentSnapshot snapshot):
        this.fromMap(snapshot.data, reference: snapshot.reference);
  toJson() {
    return {
      'name': name,
      'category': category,
      'uid' : uid,
    };
  }
}