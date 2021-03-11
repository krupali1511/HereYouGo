import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:here_you_go_1/models/userModel.dart';
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
  userModel usermodel = new userModel();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: size.height,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/images/welcome.jpg",
                height: size.height * 0.45,
              ),
              SizedBox(height: size.height * 0.05),
              SizedBox(
                width: 300.0,
                height: 80.0,
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    fillColor: Colors.black87,
                    filled: true,
                    hintText: "Enter Email",
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(50.0),
                      ),
                    ),
                    focusedBorder: new OutlineInputBorder(
                      borderSide: BorderSide(color:Colors.black87),
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(50.0),
                      ),
                    ),
                  ),
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
              ),
              SizedBox(
                width: 300.0,
                height: 80.0,
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  obscureText: true,
                  decoration: InputDecoration(
                    fillColor: Colors.black87,
                    filled: true,
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.white,
                    ),
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(50.0),
                      ),
                    ),
                    focusedBorder: new OutlineInputBorder(
                      borderSide: BorderSide(color:Colors.black87),
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(50.0),
                      ),
                    ),
                    hintText: "Enter Password",
                   hintStyle: TextStyle(color: Colors.white),
                   focusColor: Colors.white,
                  ),
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
              ),
              SizedBox(
                height: 70.0,
                width: 300.0,
                child: RaisedButton(
                  color: Colors.black87,
                  child: Text("SignIn", style: TextStyle(color: Colors.white),),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  onPressed: () async {
                    if (email.isEmpty || password.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                            title: Center(child: Text("Oops!")),
                            content: Text("Every field is required"),
                          );
                        },
                      );
                    } else {
                      dynamic result = await _auth.signInWithEmailAndPassword(
                          email, password);
                      if (result == null) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
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
                color: kPrimaryLightColor,
              ),
              InkWell(
                focusColor:Colors.black87,
                onTap: ()async {
                    bool res = (await AuthService().signInWithGoogle(usermodel)) as bool;
                    if (!res) print("error from button");
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: SvgPicture.asset(
                      'assets/svg/icon_google.svg',height: 50,width: 50,),
                  ),
              ),

              FlatButton(
                child: Text(
                  'Create Account SignUn',
                  style: TextStyle(
                    color: kPrimaryColor,
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
    );
  }
}
