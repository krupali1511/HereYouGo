import 'package:cloud_firestore/cloud_firestore.dart';
class ExpenseModel {
  String note;
  double amount;
  DocumentReference reference;
  ExpenseModel({this.note,this.amount});
  ExpenseModel.fromMap(Map<String,dynamic> map, {this.reference}){
    note = map["note"];
    amount = map["amount"];
  }
  ExpenseModel.fromSnapshot(DocumentSnapshot snapshot):
        this.fromMap(snapshot.data, reference: snapshot.reference);
  toJson(){
    return {'note':note,
            'amount': amount};
  }
}

