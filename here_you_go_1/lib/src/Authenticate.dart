import 'package:flutter/material.dart';
import 'package:here_you_go_1/src/Login.dart';
import 'package:here_you_go_1/src/registration.dart';


class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView(){
    setState(()=> showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if(showSignIn)
    {
      return Login(toggleView: toggleView);
    }
    else{
      return SignUp(toggleView: toggleView);
    }
  }
}
