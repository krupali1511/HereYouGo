import 'package:cloud_firestore/cloud_firestore.dart';
class BlogModel{
  String title;
  String description;
  String image;
  DocumentReference reference;
  BlogModel({this.title,this.description,this.image});
  BlogModel.fromMap(Map<String,dynamic> map,{this.reference}){
    title=map['blogname'];
    description=map['description'];
    image=map['picture'];
  }
  BlogModel.fromSnapshot(DocumentSnapshot snapshot):
        this.fromMap(snapshot.data, reference: snapshot.reference);
  toJson(){
    return {'blogname':title,
      'description': description,
      'picture': image,
    };
  }

}