import 'package:book_recommend/widgets/sizeconfig.dart';
import 'package:flutter/material.dart';

class SkipContent extends StatelessWidget {
  const SkipContent({
    Key key,
    this.text,
    this.image,
  }) : super(key: key);
  final String text, image;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Image.asset(
          'assets/icons/logo.png',
          // height: getProportionateScreenHeight(80),
          width: getProportionateScreenWidth(150),
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
          ),
        ),
        Image.asset(
          image,
          height: getProportionateScreenHeight(380),
          width: getProportionateScreenWidth(400),
        ),
      ],
    );
  }
}
