import 'package:book_recommend/constant.dart';
import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
      width: size.width * 0.8,
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: kBackground1,
              height: 1.5,
              thickness: 1.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              'Or',
              style: TextStyle(color: kBackground2),
            ),
          ),
          Expanded(
            child: Divider(
              color: kBackground1,
              height: 1.5,
              thickness: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}
