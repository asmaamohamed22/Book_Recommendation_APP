import 'package:flutter/material.dart';

Color kBackground1 = Color(0xFF9BC7E6);
Color kBackground2 = Color(0xFF06597B);
Color kBackground3 = Color(0xFFF5BF7D);

const kAnimationDuration = Duration(milliseconds: 200);
const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF9BC7E6), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF9BC7E6), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
  ),
);
