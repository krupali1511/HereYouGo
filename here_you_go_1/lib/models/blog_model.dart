import 'package:cloud_firestore/cloud_firestore.dart';
class BlogModel{
  String title;
  String description;
  String image;
  String tripID;
  String category;
  String uid;
  DocumentReference reference;
  BlogModel({this.title,this.description,this.image,this.tripID,this.category,this.uid});
  BlogModel.fromMap(Map<String,dynamic> map,{this.reference}){
    title=map['blogname'];
    description=map['description'];
    image=map['picture'];
    tripID = map['tripID'];
    category = map['catagory'];
    uid = map['uid'];
  }
  BlogModel.fromSnapshot(DocumentSnapshot snapshot):
        this.fromMap(snapshot.data, reference: snapshot.reference);
  toJson(){
    return {'blogname':title,
      'description': description,
      'picture': image,
      'tripID': tripID,
      'category': category,
      'uid':uid,
    };
  }

}