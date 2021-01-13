import 'dart:async';
import 'package:book_recommend/constant.dart';
import 'package:book_recommend/screens/skip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Splash extends StatefulWidget {
  static String id = 'Splash';
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
        () => Navigator.pushNamed(context, SkipScreen.id));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/online.png',
            width: size.width * 0.6,
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          SpinKitThreeBounce(
            size: 40.0,
            color: kBackground1,
          ),
        ],
      ),
    );
  }
}
