import 'package:book_recommend/constant.dart';
import 'package:book_recommend/onBoarding/config/size_config.dart';
import 'package:book_recommend/screens/welcome.dart';
import 'package:flutter/material.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.defaultSize),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(WelcomeScreen.id);
            },
            child: Text(
              'Skip',
              style: TextStyle(
                  fontSize: SizeConfig.defaultSize * 1.9, //19
                  color: kBackground2,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}
