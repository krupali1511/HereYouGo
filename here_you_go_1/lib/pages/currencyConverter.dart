import 'package:flutter/material.dart';
import 'package:flutter_currency_converter/Currency.dart';
import 'package:flutter_currency_converter/flutter_currency_converter.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:here_you_go_1/bloc.navigation_bloc/navigation_bloc.dart';
import 'dart:math' as math;

class CurrencyPage extends StatefulWidget with NavigationStates{
  @override
  _CurrencyPageState createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> with TickerProviderStateMixin {
  AnimationController _controller;
  static String currencyTo ;
  static String currencyFrom;
  static String dropdownValuefrom;
  static String dropdownValueto;
  static String displayAmount;
  static double curencyAmount = 0.00;
  static double amount = 0.00;
  final amounttxt = TextEditingController();

  currencyCheck(double amount) async {
    try {
      print("currencycheck");
      curencyAmount = await FlutterCurrencyConverter.convert(
          Currency(currencyFrom, amount: amount), Currency(currencyTo)
      );
      setState(() {
        try{
          displayAmount = curencyAmount.toString();
        }
        catch(e){
          print(e.toString());
        }
      });
    } catch (e) {
      print("inside catch of currencycheck");
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: 0.0,
      duration: Duration(seconds: 25),
      upperBound: 1,
      lowerBound: -1,
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Currency Converter"
            ),
          ),
          backgroundColor: Colors.black,
        ),
        body:SingleChildScrollView(
          child:  Column(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (BuildContext context, Widget child) {
                      return ClipPath(
                        clipper: DrawClip(_controller.value),
                        child: Container(
                          height: size.height * 0.7,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors: [Color(0xff00019d), Color(0xff000000)]),
                          ),
                        ),
                      );
                    },
                  ),

                  Container(
                    padding: EdgeInsets.only(top: 150),
                    child: Text(
                      "$amount $currencyFrom",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 190),
                    child: Text(
                      '$displayAmount $currencyTo',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 420),

                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:<Widget> [
                            Padding(
                              padding: const EdgeInsets.only(right:10.0),
                              child: DropdownButton<String>(
                                value: dropdownValuefrom,
                                icon: const Icon(Icons.arrow_downward,color: Colors.black,),
                                iconSize: 24,
                                elevation: 16,
                                style: GoogleFonts.lato(color: Colors.black,fontSize: 24),
                                underline: Container(
                                height: 2,
                                color: Colors.black,
                                ),
                                onChanged: (String newValue) {
                                  setState(() {
                                    dropdownValuefrom = newValue;
                                    currencyFrom = newValue;
                                  });
                                },
                                items: <String>['USD','LKR', 'EUR', 'JPY', 'GBP', 'AUD', 'CAD', 'CHF', 'CNY', 'HKD', 'NZD', 'SEK', 'KRW', 'SGD', 'NOK', 'MXN', 'INR', 'RUB', 'ZAR', 'TRY', 'BRL', 'TWD', 'DKK', 'PLN', 'THB', 'IDR', 'HUF', 'CZK', 'ILS', 'CLP', 'PHP', 'AED', 'COP', 'SAR', 'MYR', 'RON',]
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                            RawMaterialButton(
                              onPressed: () {
                                amount = double.parse(amounttxt.text);
                                currencyCheck(amount);
                              },
                              elevation: 2.0,
                              fillColor: Colors.white,
                              child: SvgPicture.asset("assets/svg/convert.svg",height: 50,width: 50,),
                              padding: EdgeInsets.all(15.0),
                              shape: CircleBorder(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:10.0),
                              child: DropdownButton<String>(
                                dropdownColor: Colors.white,
                                value: dropdownValueto,
                                icon: const Icon(Icons.arrow_downward,color: Colors.black,),
                                iconSize: 24,
                                elevation: 16,
                                style: GoogleFonts.lato(color: Colors.black,fontSize: 24),
                                underline: Container(
                                height: 2, color: Colors.black,
                                ),
                                onChanged: (String newValue) {
                                  setState(() {
                                    dropdownValueto = newValue;
                                    currencyTo = newValue;
                                  });
                                },
                                items: <String>['USD','LKR', 'EUR', 'JPY', 'GBP', 'AUD', 'CAD', 'CHF', 'CNY', 'HKD', 'NZD', 'SEK', 'KRW', 'SGD', 'NOK', 'MXN', 'INR', 'RUB', 'ZAR', 'TRY', 'BRL', 'TWD', 'DKK', 'PLN', 'THB', 'IDR', 'HUF', 'CZK', 'ILS', 'CLP', 'PHP', 'AED', 'COP', 'SAR', 'MYR', 'RON',]
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),

                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:18.0),
                          child: SizedBox(
                            width: 250,
                            child: TextField(
                              controller: amounttxt,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                filled: true,
                                prefixIcon: Icon(
                                  Icons.money,
                                  color: Colors.black,
                                ),
                                hintText: "Amount",

                                suffixIcon: amounttxt.text.isNotEmpty
                                    ? GestureDetector(
                                  onTap: () {
                                    WidgetsBinding.instance.addPostFrameCallback(
                                            (_) => amounttxt.clear());
                                  },
                                  child: Icon(
                                    Icons.clear,
                                    color: Colors.black,
                                  ),
                                )
                                    : null,
                                hintStyle: GoogleFonts.lato(color: Colors.black,fontSize: 22),
                                focusColor: Colors.white,
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),

                            ),
                          ),
                        ),

                      ],
                    ),
                  ),

                ],
              ),

            ],
          ),
        ),


      ),
    );
  }
}
class DrawClip extends CustomClipper<Path> {
  double move = 0;
  double slice = math.pi;
  DrawClip(this.move);
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.8);
    double xCenter =
        size.width * 0.5 + (size.width * 0.6 + 1) * math.sin(move * slice);
    double yCenter = size.height * 0.8 + 69 * math.cos(move * slice);
    path.quadraticBezierTo(xCenter, yCenter, size.width, size.height * 0.8);

    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
