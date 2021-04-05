import 'package:book_recommend/constant.dart';
import 'package:book_recommend/screens/welcome.dart';
import 'package:book_recommend/widgets/roundedbutton.dart';
import 'package:book_recommend/widgets/sizeconfig.dart';
import 'package:book_recommend/widgets/skipcontent.dart';
import 'package:flutter/material.dart';

class SkipScreen extends StatefulWidget {
  static String id = 'SkipScreen';
  @override
  _SkipScreenState createState() => _SkipScreenState();
}

class _SkipScreenState extends State<SkipScreen> {
  int currentPage = 0;
  List<Map<String, String>> skipData = [
    {
      "text": "Get personalized recommended book for you",
      "image": "assets/skip/reading.png",
    },
    {
      "text": "Discover new books based on your interest",
      "image": "assets/skip/search.png",
    },
    {
      "text": "Make a library of your favourites",
      "image": "assets/skip/favourite.png",
    },
  ];
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: skipData.length,
                  itemBuilder: (context, index) => SkipContent(
                    text: skipData[index]['text'],
                    image: skipData[index]["image"],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        skipData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(),
                    RoundedButton(
                      text: 'Continue',
                      press: () {
                        Navigator.pushNamed(
                            context, WelcomeScreen.id);
                      },
                      color: kBackground2,
                      textColor: Colors.white,
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kBackground2 : Colors.grey,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
