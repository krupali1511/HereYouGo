import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:here_you_go_1/models/trips.dart';

import '../bloc.navigation_bloc/navigation_bloc.dart';

class MyBlogPage extends StatelessWidget with NavigationStates {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Blogs"
        ),
      ),
      body: MyBlogs(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
        },
        label: Text('Create new'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.black54,
      ),

    );
  }
}
class MyBlogs extends StatefulWidget {
  @override
  _MyBlogsState createState() => _MyBlogsState();
}

class _MyBlogsState extends State<MyBlogs> {
  final _pageController = new PageController(viewportFraction: 0.877);
  @override
  Widget build(BuildContext context) {
    return  Container(
        padding: EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: trip.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0
          ),
          itemBuilder: (BuildContext context, int index){
            return  InkWell(
              child: Container(
                margin: EdgeInsets.all(5.8),
               // width: 333.6,
                //height: 218.4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9.6),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(trip[index].image))),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      bottom: 19.2,
                      left: 19.2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4.8),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 19.2,
                            sigmaY: 19.2,
                          ),
                          child: Container(
                            height: 36,
                            padding: EdgeInsets.only(
                                left: 16.72, right: 14.4),
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: <Widget>[
                                SvgPicture.asset(
                                    'assets/svg/icon_location.svg'),
                                SizedBox(
                                  width: 9.52,
                                ),
                                Text(
                                  trip[index].name,
                                  style: GoogleFonts.lato(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      fontSize: 16.8),
                                ),
                                Text(
                                  "",
                                  style: GoogleFonts.lato(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      fontSize: 16.8),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            );
          },

        ),
    );

  }
}
