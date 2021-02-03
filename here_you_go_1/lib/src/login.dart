import 'package:flutter/material.dart';
import 'package:here_you_go_1/src/constants.dart';
import 'package:here_you_go_1/services/auth.dart';

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kPrimaryLightColor,
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
                  decoration: InputDecoration(
                    hintText: "Enter Email",
                    prefixIcon: Icon(
                      Icons.email,
                      color: kPrimaryColor,
                    ),
                    border: new OutlineInputBorder(
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
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock,
                      color: kPrimaryColor,
                    ),
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(50.0),
                      ),
                    ),
                    hintText: "Enter Password",
                    focusColor: kPrimaryLightColor,
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
                  color: kPrimaryColor,
                  child: Text("SignIn"),
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
              RaisedButton.icon(
                onPressed: () async {
                  bool res = await AuthService().loginWithGoogle();
                  if (!res) print("error from button");
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                label: Text(
                  'Login with Google',
                  style: TextStyle(color: Colors.white),
                ),
                icon: Icon(
                  Icons.language,
                  color: Colors.white,
                ),
                textColor: Colors.white,
                splashColor: Colors.red,
                color: kPrimaryColor,
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
