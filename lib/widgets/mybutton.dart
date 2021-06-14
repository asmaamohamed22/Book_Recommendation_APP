import 'package:book_recommend/constant.dart';
import 'package:book_recommend/onBoarding/config/size_config.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function onPressed;
  final String name;
  MyButton({this.onPressed, this.name});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      child: RaisedButton(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.defaultSize * 4.6,
          vertical: SizeConfig.defaultSize * 1.4,
        ),
        onPressed: onPressed,
        child: Text(
          name,
          style: TextStyle(
            color: Colors.white,
            fontSize: SizeConfig.defaultSize * 1.6,
          ),
        ),
        color: kBackground2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
      ),
    );
  }
}
