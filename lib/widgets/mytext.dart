import 'package:book_recommend/constant.dart';
import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final TextEditingController controller;
  final String name;

  MyText({
    this.controller,
    this.name,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF9BC7E6), width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kBackground2, width: 2.0),
        ),
        hintText: name,
      ),
    );
  }
}
