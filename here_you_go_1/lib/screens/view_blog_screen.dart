import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:here_you_go_1/models/blog_model.dart';
import 'add_blog_screen.dart';
import 'package:here_you_go_1/models/blog_model.dart';

class ViewBlog extends StatefulWidget {
  @override
  _ViewBlogState createState() => _ViewBlogState();
}

class _ViewBlogState extends State<ViewBlog> {
  String collection = "blogs";
  final firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('View Blogs'),),
      body: StreamBuilder(
        stream: firestore.collection(collection).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text('No Data Available'),
            );
          }
          return ListView(
              children: snapshot.data.documents.map((document) {


                /*return Center(
                child: Container(
                  child: Text("Name="+document['name']),
                ),
              );*/

                return Container(
                    margin: EdgeInsets.only(bottom: 24),
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(6),
                                bottomLeft: Radius.circular(6))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.network(
                                  document.data['picture'],
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                )),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              document['blogname'],
                              maxLines: 2,
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              document['description'],
                              maxLines: 2,
                              style: TextStyle(color: Colors.black54, fontSize: 14),
                            )
                          ],
                        ),
                      ),
                    ));
              }).toList());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddBlog()));
        },
        child: Icon(Icons.add),

      ),
    );
  }
}
