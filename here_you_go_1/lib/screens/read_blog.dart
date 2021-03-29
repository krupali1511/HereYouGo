import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ReadBlog extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Blogs"),
        ),
        body: BlogScreen(),
      ),
    );
  }
}
class BlogScreen extends StatefulWidget {

  final DocumentSnapshot blogSnapshot;
  BlogScreen({this.blogSnapshot});

  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {

  String  collection="blogs";
  final firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blogs"),
      ),
      body: SingleChildScrollView(
        child: Container(
          width : double.infinity,
          child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child:SizedBox(
              child: Column(
                children: <Widget>[

                  Image.network(
                    //'https://placeimg.com/640/480/bike',
                    widget.blogSnapshot.data["picture"],
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      /*"1I'm building a layout with a GridView and Cards. "
                        "I want to put a color to the bottom of each card. I found"
                        " this question Fill an area with color in Flutter and tried "
                        "to do the same trick for bottom, but each time The SizedBox "
                        "Overflows the round card corners. Any idea of how to fix this?   "
                        " The sample code below shows the issue. I try to color the "
                        "bottom part of the card, and when I do this, the corners of "
                        "the card are lost, like overflow from the Container.",*/
                      widget.blogSnapshot.data["blogname"],
                      style: GoogleFonts.lato(
                        fontSize: 20, fontWeight: FontWeight.w800,
                        ),
                      ),
                      ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      /*"1I'm building a layout with a GridView and Cards. "
                        "I want to put a color to the bottom of each card. I found"
                        " this question Fill an area with color in Flutter and tried "
                        "to do the same trick for bottom, but each time The SizedBox "
                        "Overflows the round card corners. Any idea of how to fix this?   "
                        " The sample code below shows the issue. I try to color the "
                        "bottom part of the card, and when I do this, the corners of "
                        "the card are lost, like overflow from the Container.",*/
                      widget.blogSnapshot.data["description"],
                      style: GoogleFonts.lato(
                        fontSize: 18, fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      height: 57.6,
                      margin: EdgeInsets.only(top: 28.8, left: 28.8, right: 28.8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          //custom nav drawer
                          Container(
                            height: 57.6,
                            width: 57.6,
                            padding: EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9.6),
                              color: Color(0x080a0928),
                            ),
                            child: SvgPicture.asset("assets/svg/icon_drawer.svg"),
                          ),
                          Container(
                            padding: EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9.6),
                              color: Color(0x080a0928),
                            ),
                            child: Text("Username"),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ) ,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            margin: EdgeInsets.all(10),

          ),
        ),
      ),
    );
  }
}

