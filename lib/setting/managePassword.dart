import 'package:book_recommend/constant.dart';
import 'package:book_recommend/models/usermodel.dart';
import 'package:book_recommend/setting/setting.dart';
import 'package:book_recommend/widgets/mybutton.dart';
import 'package:flutter/material.dart';

class ManagePassword extends StatefulWidget {
  static String id = 'ManagePassword';
  final UserModel currentUser;

  ManagePassword({this.currentUser});
  @override
  _ManagePasswordState createState() => _ManagePasswordState();
}

class _ManagePasswordState extends State<ManagePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, Setting.id);
          },
          icon: Icon(
            Icons.arrow_back,
            color: kBackground2,
            size: 35,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Password',
          style: TextStyle(
            color: kBackground2,
            fontSize: 25,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
    );
  }
}
