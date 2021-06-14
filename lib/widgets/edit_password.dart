import 'package:book_recommend/constant.dart';
import 'package:book_recommend/screens/login.dart';
import 'package:flutter/material.dart';

class EditPassword extends StatelessWidget {
  final TextEditingController controller;
  final String name;

  EditPassword({
    this.controller,
    this.name,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF9BC7E6), width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kBackground2, width: 2.0),
        ),
        hintText: name,
      ),
    );
  }
}
