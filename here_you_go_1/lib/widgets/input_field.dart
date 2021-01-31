import 'package:flutter/material.dart';
class InputField extends StatelessWidget {

  final String labelText;
  final int maxLines;
  final TextEditingController controller;
  InputField({this. labelText,this.maxLines,this.controller});
  @override
  Widget build(BuildContext context) {


    return TextFormField(
      maxLines: maxLines,
      controller: controller,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2.0),
              borderRadius: BorderRadius.circular(15)
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.lightBlue, width: 2.0),
              borderRadius: BorderRadius.circular(15)
          ),
          labelText: labelText,
          labelStyle: TextStyle(
            color: Colors.blue,
            fontSize: 17.0,
          )
      ),
    );
  }
}
