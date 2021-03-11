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
          backgroundColor: Colors.black87,
          title: Text("Blogs",style: TextStyle(color: Colors.white),),
        ),
        body: BlogScreen(),
      ),
    );
  }
}
class BlogScreen extends StatefulWidget {
  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width : double.infinity,
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child:SizedBox(
            child: Column(
              children: <Widget>[
                Image(image: AssetImage('assets/images/b.jpg')),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text("Bali is a favorite destination for many people around the world and it’s easy to see why! From its list of unending idyllic beaches, captivating spiritual energy, terraced rice fields and exotic sunsets. There is so much to see and experience on this magnificent island paradise! Going to Bali feels like going on a never-ending adventure – there is an activity to suit every soul! Experience surfing, yoga, meditation, trekking, delicious food or amazing nightlife. Certain areas of Bali have been influenced by tourism, with hubs of cute cafes, hip bars, and vegan restaurants. Other areas are still quite remote, maintaining their uniquely Balinese beauty and charm.", style: GoogleFonts.lato(
                      fontSize: 18, fontWeight: FontWeight.w500,
                      ),),
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
    );
  }
}

