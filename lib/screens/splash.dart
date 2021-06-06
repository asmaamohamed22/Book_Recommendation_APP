import 'dart:async';
import 'package:book_recommend/constant.dart';
import 'package:book_recommend/screens/skip.dart';
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
    // Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Opacity(
                opacity: 0.5,
                child: Image.asset(
                  'assets/images/background.jpg',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Shimmer.fromColors(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'Recme',
                  style: TextStyle(
                    fontFamily: 'pacifico',
                    fontSize: 80,
                    shadows: [
                      Shadow(
                        blurRadius: 15,
                        color: kBackground1,
                        offset: Offset.fromDirection(120, 12),
                      ),
                    ],
                  ),
                ),
              ),
              baseColor: kBackground2,
              highlightColor: kBackground1,
            ),
          ],
        ),
      ),
    );
  }
}
