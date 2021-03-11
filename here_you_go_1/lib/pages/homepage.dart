import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:here_you_go_1/models/trips.dart';
import 'package:here_you_go_1/pages/selected_place_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../bloc.navigation_bloc/navigation_bloc.dart';

class HomePage extends StatelessWidget with NavigationStates {
  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pageController = new PageController(viewportFraction: 0.877);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Container(
                height: 57.6,
                margin: EdgeInsets.only(top: 28.8, left: 28.8, right: 28.8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
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
                      child: SvgPicture.asset("assets/svg/icon_search.svg"),
                    )
                  ],
                ),
              ),
              //text
              Padding(
                padding: EdgeInsets.only(
                  top: 48,
                  left: 28.8,
                ),
                child: Text(
                  "Here You Go!!",
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 45.6,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              //custom tab bar with indicator
              Container(
                height: 30,
                margin: EdgeInsets.only(left: 14.4, top: 28.8),
                child: DefaultTabController(
                  length: 4,
                  //custom tabbar
                  child: TabBar(
                    labelPadding: EdgeInsets.only(left: 14.4, right: 14.4),
                    indicatorPadding: EdgeInsets.only(left: 14.4, right: 14.4),
                    isScrollable: true,
                    labelColor: Color(0xff000000),
                    unselectedLabelColor: Color(0xff8a8a8a),
                    labelStyle: GoogleFonts.lato(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                    unselectedLabelStyle: GoogleFonts.lato(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                    indicatorColor: Color(0xff8a8a8a),
                    tabs: [
                      Tab(
                        child: Container(
                          child: Text('Recommended'),
                        ),
                      ),
                      Tab(
                        child: Container(
                          child: Text('Popular'),
                        ),
                      ),
                      Tab(
                        child: Container(
                          child: Text('Something New'),
                        ),
                      ),
                      Tab(
                        child: Container(
                          child: Text('Off the Grid'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SelectedPlaceScreen()));
                },
                child: Container(
                  height: 218.5,
                  margin: EdgeInsets.only(top: 16),
                  child: PageView(
                      physics: BouncingScrollPhysics(),
                      controller: _pageController,
                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                        trip.length,
                            (int index) => Container(
                          margin: EdgeInsets.only(right: 28.8),
                          width: 333.6,
                          height: 218.4,
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
                      )),
                ),
              ),
              //use smoothPageIndicator library
              Padding(
                padding: EdgeInsets.only(left: 28.8, top: 28.8),
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: trip.length,
                  effect: ExpandingDotsEffect(
                      activeDotColor: Color(0xFF8a8a8a),
                      dotColor: Color(0xffababab),
                      dotHeight: 4.8,
                      dotWidth: 6,
                      spacing: 4.8),
                ),
              ),
              //Text view
              Padding(padding: EdgeInsets.only(top:48, left: 28.8,right: 28.8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('See Also',
                      style: GoogleFonts.playfairDisplay(fontSize: 28,fontWeight: FontWeight.w700,color: Colors.black),),
                    Text('Show All',
                      style: GoogleFonts.lato(fontSize: 16.8,fontWeight: FontWeight.w500,color: Color(0xff8a8a8a)),)
                  ],


                ),
              ),
              Container(

              )
            ],
          ),
        ),
      ),
    );
  }
}
