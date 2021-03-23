import 'package:cloud_firestore/cloud_firestore.dart';
class ExpenseModel {
  String note;
  double amount;
  String tripID;
  DocumentReference reference;
  ExpenseModel({this.note,this.amount,this.tripID});
  ExpenseModel.fromMap(Map<String,dynamic> map, {this.reference}){
    note = map["note"];
    amount = map["amount"];
    tripID = map["tripID"];
  }
  ExpenseModel.fromSnapshot(DocumentSnapshot snapshot):
        this.fromMap(snapshot.data, reference: snapshot.reference);
  toJson(){
    return {'note':note,
            'amount': amount,
            'tripID': tripID,
    };
  }
}