import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:here_you_go_1/models/blog_model.dart';
import 'package:here_you_go_1/widgets/input_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';


class AddBlog extends StatefulWidget {
  @override
  _AddBlogState createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {

  File file;
  File image;
  String filename;
  String uploadedFileURL;
  final titleController=TextEditingController();
  final descriptionController=TextEditingController();
  String collection="blogs";
  final firestore=Firestore.instance;
  FirebaseStorage storage;

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

    /*StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('images/${Path.basename(file .path)}');
    StorageUploadTask uploadTask = storageReference.putFile(file);
    uploadTask.onComplete;
    print('File Uploaded');
    var uploadedURL=storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        uploadedFileURL = fileURL;
      });
    });*/


    uploadPic(context).then((value) {
      BlogModel blog=BlogModel(title: titleController.text,description: descriptionController.text,image: value);
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
      appBar: AppBar(
        title: Text('Add Blog'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                InputField(labelText: 'Title of Blog',maxLines: 1,controller: titleController,),
                SizedBox(height: 10.0),
                InputField(labelText: 'Description of Blog',maxLines: 5,controller: descriptionController,),
                SizedBox(height: 10.0),
                file==null?Center(child: Text('No Image has selected')): ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.file(
                      file,
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    )),

                SizedBox(height: 20.0),
                Row(
                  children: <Widget>[
                    Expanded(child: Text(filename==null?'No image selected':filename)),
                    Expanded(
                      child: Container(
                        height: 55,
                        width: 150,
                        child: FlatButton(

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),

                          color: Colors.blue,
                          textColor: Colors.white,
                          padding: EdgeInsets.all(8.0),
                          onPressed: () => pickImage(),
                          child: Text(
                            'Upload Image',
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    )],
                ),
                SizedBox(height: 50.0),
                Container(
                  height: 55,
                  width: double.infinity,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: BorderSide(color: Colors.blue)
                    ),
                    color: Colors.blue,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(8.0),
                    onPressed: () {addBlog();},
                    child: Text(
                      "Add Blog",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



