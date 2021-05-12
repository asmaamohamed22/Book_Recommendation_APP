import 'package:book_recommend/constant.dart';
import 'package:book_recommend/screens/login.dart';
import 'package:book_recommend/widgets/mybutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  static String id = 'ResetPassword';
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  String _email;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Reset Password',
          style: TextStyle(
            fontSize: 20.0,
            color: kBackground2,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, LoginScreen.id);
          },
          icon: Icon(
            Icons.arrow_back,
            color: kBackground2,
            size: 35,
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.03,
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
              onChanged: (value) {
                setState(() {
                  _email = value;
                });
              },
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            MyButton(
              name: 'Send Request',
              onPressed: () {
                auth.sendPasswordResetEmail(email: _email);
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }
}
