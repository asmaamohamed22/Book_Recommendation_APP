import 'package:book_recommend/constant.dart';
import 'package:book_recommend/screens/register.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(29.0),
          side: BorderSide(color: kBackground2),
        ),
        onPressed: () {
          Navigator.pushNamed(context, RegisterScreen.id);
        },
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Container(
          child: Text(
            'Register',
            style: TextStyle(color: kBackground2, fontSize: 18.0),
          ),
        ),
      ),
    );
  }
}
