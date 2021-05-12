import 'package:book_recommend/adminPages/AdminWidgets/adminContent.dart';
import 'package:book_recommend/constant.dart';
import 'package:book_recommend/screens/home.dart';
import 'package:book_recommend/setting/darkmode.dart';
import 'package:book_recommend/setting/managePassword.dart';
import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  static String id = 'Setting';
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, HomeScreen.id);
          },
          icon: Icon(
            Icons.arrow_back,
            color: kBackground2,
            size: 35,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Setting',
          style: TextStyle(
            //fontWeight: FontWeight.bold,
            color: kBackground2,
            fontSize: 25,
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            Column(
              children: [
                AdminContent(
                  name: 'Dark Mode',
                  icon: Icon(
                    Icons.lightbulb,
                    color: Colors.white,
                    size: 35,
                  ),
                  ontap: () {
                    Navigator.pushReplacementNamed(context, DarkMode.id);
                  },
                ),
                SizedBox(
                  width: 20,
                ),
                AdminContent(
                  name: 'Manage Password',
                  icon: Icon(
                    Icons.lock,
                    color: Colors.white,
                    size: 35,
                  ),
                  ontap: () {
                    Navigator.pushReplacementNamed(context, ManagePassword.id);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
