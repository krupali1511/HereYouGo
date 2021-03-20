import 'package:cloud_firestore/cloud_firestore.dart';
class User{
  String uid;
  String name;
  String email;
  String image;
  String bio;
  String country;
  String state;
  String mobile;
  DocumentReference reference;
  User({this.uid,this.name,this.email,this.image, this.bio, this.country, this.state, this.mobile});
  User.fromMap(Map<String,dynamic> map,{this.reference}){
    name=map['name'];
    email=map['email'];
    image=map['image'];
    bio=map['bio'];
    country=map['country'];
    state=map['state'];
    mobile=map['mobile'];
  }
  User.fromSnapshot(DocumentSnapshot snapshot):
        this.fromMap(snapshot.data, reference: snapshot.reference);
  toJson(){
    return {'name':name,
      'email': email,
      'image': image,
      'bio': bio,
      'country': country,
      'state': state,
      'mobile': mobile,

    };
  }
}