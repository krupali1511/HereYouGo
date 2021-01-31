import 'package:flutter/material.dart';
import 'package:here_you_go_1/src/Home.dart';
import 'package:here_you_go_1/models/user.dart';
import 'package:here_you_go_1/src/Authenticate.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
