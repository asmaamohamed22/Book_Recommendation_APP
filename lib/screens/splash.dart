import 'dart:async';
import 'package:book_recommend/constant.dart';
import 'package:book_recommend/onBoarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

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
        builder: (context) => OnboardingScreen(),
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
      body: Container(
        alignment: Alignment.center,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icons/backlogo.png',
                  height: size.width * 0.3,
                ),
                Shimmer.fromColors(
                  child: Text(
                    'Recme',
                    style: TextStyle(fontSize: 40, fontFamily: 'pacifico'),
                  ),
                  baseColor: kBackground2,
                  highlightColor: kBackground1,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
