import 'package:book_recommend/constant.dart';
import 'package:book_recommend/onBoarding/config/size_config.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class MyAnimatedContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlayAnimation<double>(
      tween: Tween(
        begin: 0.0,
        end: SizeConfig.orientation == Orientation.portrait
            ? SizeConfig.screenHeight
            : SizeConfig.screenWidth,
      ),
      duration: Duration(seconds: 1),
      curve: Curves.easeOut,
      builder: (context, child, value) {
        return Image.asset(
          "assets/icons/rlogo.png",
          height: 200,
          width: 100,
        );
      },
    );
  }
}
