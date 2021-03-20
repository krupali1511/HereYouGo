import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:here_you_go_1/models/user.dart';
import 'package:here_you_go_1/src/constants.dart';
import 'package:here_you_go_1/services/auth.dart';
import 'package:path/path.dart';

class Login extends StatefulWidget {
  final Function toggleView;

  const Login({Key key, this.toggleView}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _auth = AuthService();

  String email = '';
  String password = '';
  User usermodel = new User();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/forest.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          height: size.height,
          width: double.infinity,
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Card(
              color: Colors.black54,
              child: Padding(
                padding: const EdgeInsets.only(top:30.0,bottom: 20.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom:16.0),
                      child: Text('login',
                        style:GoogleFonts.playfairDisplay(
                          fontSize: 38.6,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 320.0,
                      height: 80.0,
                      child: TextField(
                        style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 22.0,
                          fontWeight: FontWeight.w500
                        ),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          filled: true,
                          hintText: "Email",
                          hintStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.white,
                          ),

                        ),
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 320.0,
                      height: 80.0,
                      child: TextField(
                        style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 22.0,
                            fontWeight: FontWeight.w500
                        ),
                        cursorColor: Colors.white,
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.white),
                          focusColor: Colors.white,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 60.0,
                      width: 320.0,
                      child: RaisedButton(
                        color: Colors.white,
                        child: Text(
                          "SignIn",
                          style: GoogleFonts.lato(
                              color: Colors.black,
                              fontSize: 22.0,
                              fontWeight: FontWeight.w700
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        onPressed: () async {
                          if (email.isEmpty || password.isEmpty) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  title: Center(child: Text("Oops!")),
                                  content: Text("All fields are required"),
                                );
                              },
                            );
                          } else {
                            dynamic result = await _auth
                                .signInWithEmailAndPassword(email, password);
                            if (result == null) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0))),
                                    title: Center(child: Text("Oops!")),
                                    content: Text("Wrong Credentials"),
                                  );
                                },
                              );
                            }
                          }
                        },
                      ),
                    ),
                    Divider(
                      height: 30.0,
                      thickness: 2.0,
                      indent: 30,
                      endIndent: 30,
                      color: Colors.white60,
                    ),
                    InkWell(
                      focusColor: Colors.black87,
                      onTap: () async {
                        bool res = (await AuthService()
                            .loginWithGoogle());
                        if (!res) print("error from button");
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: SvgPicture.asset(
                          'assets/svg/icon_google.svg',
                          height: 50,
                          width: 50,
                        ),
                      ),
                    ),
                    FlatButton(
                      child: Text(
                        'Create Account',
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      onPressed: () {
                        widget.toggleView();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
