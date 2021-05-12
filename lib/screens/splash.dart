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
  Timer _timer;
  void startTime() async {
    _timer = Timer(Duration(seconds: 3), navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SkipScreen(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/skip/logo.png',
            width: size.width * 0.2,
            height: size.width * 0.2,
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          SpinKitThreeBounce(
            size: 35.0,
            color: kBackground1,
          ),
        ],
      ),
    );
  }
}
