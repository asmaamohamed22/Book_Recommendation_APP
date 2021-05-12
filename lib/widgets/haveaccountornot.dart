import 'package:book_recommend/constant.dart';
import 'package:flutter/material.dart';

class HaveAcountOrNot extends StatelessWidget {
  final String title;
  final String subTitle;
  final Function onTap;

  const HaveAcountOrNot({this.title, this.subTitle, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 15.0,
            color: Theme.of(context).backgroundColor,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            subTitle,
            style: TextStyle(
              color: kBackground2,
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
            ),
          ),
        ),
      ],
    );
  }
}
