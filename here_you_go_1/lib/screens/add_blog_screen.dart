import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:here_you_go_1/models/blog_model.dart';
import 'package:path/path.dart' as Path;
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';


class AddBlog extends StatefulWidget {
  @override
  _AddBlogState createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {

  File file;
  File image;
  String filename;
  String uploadedFileURL;
  bool _isLoading = false;
  String dropdownvalue = 'Category';
  

  final titleController=TextEditingController();
  final descriptionController=TextEditingController();

  String collection="blogs";
  final firestore= Firestore.instance;
  FirebaseStorage storage;

  String userid;
  getUser() async {
    String userId = ( await FirebaseAuth.instance.currentUser()).uid;
    userid = userId;
  }


  getBlog(){
    return firestore.collection(collection).snapshots();
  }

  Future pickImage()async{
    PickedFile pickedFile=await ImagePicker().getImage(source: ImageSource.gallery);
    file=File(pickedFile.path);
    uploadedFileURL=file.uri.toString();
    filename=Path.basename(file.path);
    setState(() {
      this.image = file;
    });
  }

  Future<String> uploadPic(BuildContext context) async {
    String fileName = Path.basename(image.path);
    StorageReference firebaseStorageRef =
    FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }


  Future addBlog() {

    uploadPic(context).then((value) {
      BlogModel blog=BlogModel(title: titleController.text,description: descriptionController.text,image: value,category: dropdownvalue,uid: userid);
      try{
        firestore.runTransaction(
              (Transaction transaction) async {
            await Firestore.instance
                .collection(collection)
                .document()
                .setData(blog.toJson());
          },
        );
        print('Data Added');
        print(DateTime.now().minute);
        titleController.clear();
        descriptionController.clear();
      }
      catch(e){
        print(e.toString());
      }
    });
  }

  //Function that selects the image from the galary

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title:
        Text(
          " Publish Blog",
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),

        backgroundColor: Colors.black,
        elevation: 0.0,
        actions: <Widget>[

        ],
      ),
      body: _isLoading
          ? Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      )
          :
      ListView(
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: WaveClipperTwo(),
                child: Container(
                  decoration: BoxDecoration(
                    color:Colors.black,
                  ),
                  height: MediaQuery.of(context).size.height / 4,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                        onTap: () {
                          //getImage();
                          pickImage();
                        },
                        child: /*selectedImage*/ file != null
                            ? Container(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          height: 170,
                          width: MediaQuery.of(context).size.width,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.file(
                              /*selectedImage*/ file,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                            : Container(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          height: 170,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6)),
                          width: MediaQuery.of(context).size.width,
                          child: Icon(
                            Icons.add_a_photo,
                            color: Colors.black45,
                          ),
                        )),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: <Widget>[
                          // TextFormField(
                          //   decoration: InputDecoration(
                          //     labelText: "Title",
                          //     fillColor: Colors.blueGrey,
                          //     focusedBorder:OutlineInputBorder(
                          //       borderSide: const BorderSide(color: Colors.blueGrey, width: 2.0),
                          //       borderRadius: BorderRadius.circular(25.0),
                          //     ),
                          //   ),
                          // )
                          Container(
                            decoration: BoxDecoration(
                              /*boxShadow: [
                                BoxShadow(
                                  color: const Color(0x29000000),
                                  offset: Offset(0, 8),
                                  blurRadius: 6,
                                ),
                              ],*/
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: "Title",
                                fillColor: Colors.white,
                                focusedBorder:OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                              controller: titleController,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0x29000000),
                                    offset: Offset(0, 8),
                                    blurRadius: 6,
                                  ),
                                ],
                                color: Colors.white
                            ),
                            child: TextField(

                              maxLines: 5,
                              decoration: InputDecoration(
                                labelText: "Description",

                                focusedBorder:OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.black, width: 2.0),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                              controller: descriptionController,
                            ),
                          ),
                          SizedBox(height: 20,),
                          Container(
                            width: 300,
                            child:DropdownButton<String>(
                              value: dropdownvalue,
                              icon: Icon(Icons.arrow_downward),
                              elevation: 16,
                              onChanged: (String val){
                                setState(() {
                                  dropdownvalue=val;
                                });
                              },
                              items: <String>['Category','HillStation','Dessert','mountains','Waterfall'].map<DropdownMenuItem<String>>((String value){
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(height: 20,),
                          ButtonTheme(
                            buttonColor: Colors.black,
                            minWidth: 500.0,
                            child: RaisedButton(

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),

                              ),
                              elevation: 16,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text('Add',style: GoogleFonts.lato(color: Colors.white),),
                              ),
                              onPressed: () {
                                addBlog();
                              },
                            ),
                          ),


                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],

      ),
    );

  }
}



