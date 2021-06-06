import 'package:book_recommend/widgets/sizeconfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SkipContent extends StatelessWidget {
  const SkipContent({
    Key key,
    this.text,
    this.image,
  }) : super(key: key);
  final String text, image;

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
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
        SizedBox(
          height: 20,
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).backgroundColor,
            fontSize: 17,
          ),
        ),
        SizedBox(
          height: 40,
        ),
        SvgPicture.asset(
          image,
          height: getProportionateScreenHeight(240),
          width: getProportionateScreenWidth(350),
        ),
      ],
    );
  }
}
