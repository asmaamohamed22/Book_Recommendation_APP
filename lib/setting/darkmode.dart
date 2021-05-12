import 'package:book_recommend/constant.dart';
import 'package:book_recommend/setting/setting.dart';
import 'package:book_recommend/widgets/changebutton.dart';
import 'package:flutter/material.dart';

class DarkMode extends StatefulWidget {
  static String id = 'DarkMode';
  @override
  _DarkModeState createState() => _DarkModeState();
}

class _DarkModeState extends State<DarkMode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Dark Mode',
              style: TextStyle(
                  color: Theme.of(context).backgroundColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            ChangeThemeButtonWidget(),
          ],
        ),
      ),
    );
  }
}
