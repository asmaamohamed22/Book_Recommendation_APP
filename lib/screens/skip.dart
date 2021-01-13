import 'package:book_recommend/constant.dart';
import 'package:book_recommend/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class SkipScreen extends StatefulWidget {
  static String id = 'SkipScreen';
  @override
  _SkipScreenState createState() => _SkipScreenState();
}

class _SkipScreenState extends State<SkipScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Carousel(
        animationDuration: Duration(seconds: 2),
        animationCurve: Curves.fastOutSlowIn,
        autoplay: true,
        boxFit: BoxFit.cover,
        dotBgColor: Colors.transparent,
        dotIncreasedColor: Theme.of(context).primaryColor,
        dotSize: 8,
        showIndicator: true,
        images: [
          AssetImage(
            'assets/skip/skip1.png',
          ),
          AssetImage(
            'assets/skip/skip2.png',
          ),
          AssetImage(
            'assets/skip/skip3.png',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kBackground1,
        onPressed: () {
          Navigator.pushNamed(context, WelcomeScreen.id);
        },
        child: Icon(
          Icons.arrow_forward,
          color: kBackground2,
          size: 30.0,
        ),
      ),
    );
  }
}
