import 'package:book_recommend/constant.dart';
import 'package:flutter/material.dart';

class MyTextFormField extends StatefulWidget {
  @override
  _TextFormFieldState createState() => _TextFormFieldState();
}

class _TextFormFieldState extends State<TextFormField> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        TextFormField(
          decoration: kTextFieldDecoration.copyWith(
            hintText: 'Username',
            prefixIcon: Icon(
              Icons.person,
              color: kBackground2,
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: kTextFieldDecoration.copyWith(
            hintText: 'Email',
            prefixIcon: Icon(
              Icons.email,
              color: kBackground2,
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        TextFormField(
          obscureText: true,
          decoration: kTextFieldDecoration.copyWith(
            hintText: 'Password',
            prefixIcon: Icon(
              Icons.lock,
              color: kBackground2,
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        TextFormField(
          decoration: kTextFieldDecoration.copyWith(
            hintText: 'Phonenumber',
            prefixIcon: Icon(
              Icons.phone,
              color: kBackground2,
            ),
          ),
        ),
      ],
    );
  }
}
