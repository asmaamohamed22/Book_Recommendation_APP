import 'dart:ui';
import 'package:book_recommend/constant.dart';
import 'package:book_recommend/onBoarding/config/size_config.dart';
import 'package:book_recommend/screens/home.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  static String id = 'AboutScreen';
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, HomeScreen.id);
          },
          icon: Icon(
            Icons.arrow_back,
            color: kBackground2,
            size: SizeConfig.defaultSize * 3,
          ),
        ),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.defaultSize * 1,
                vertical: SizeConfig.defaultSize * 1,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.defaultSize * 1,
                    ),
                    child: Text(
                      "About",
                      style: TextStyle(
                        fontSize: SizeConfig.defaultSize * 3,
                        color: kBackground2,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/iconbook.png',
                      width: SizeConfig.defaultSize * 18,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.defaultSize * 1.5,
                  ),
                  Text(
                    'Who we are ?',
                    style: TextStyle(
                      fontSize: SizeConfig.defaultSize * 1.9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.defaultSize * 0.5,
                  ),
                  Text(
                    'Recme is book recommendation app',
                    style: TextStyle(
                      fontSize: SizeConfig.defaultSize * 1.7,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.defaultSize * 0.6,
                  ),
                  Text(
                    'Since 2021 we make people happy with our services ,This app you can get on all recommendation book that you want to be recommended for you.',
                    style: TextStyle(
                      fontSize: SizeConfig.defaultSize * 1.4,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.defaultSize * 2,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: kBackground2,
                        maxRadius: SizeConfig.defaultSize * 2,
                        child: Icon(
                          Icons.email_outlined,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.defaultSize * 0.8,
                      ),
                      Text(
                        'developers_team@gmail.com',
                        style: TextStyle(
                          fontSize: SizeConfig.defaultSize * 1.3,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.defaultSize * 0.8,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: kBackground2,
                        maxRadius: SizeConfig.defaultSize * 2,
                        child: Icon(
                          Icons.home_outlined,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.defaultSize * 0.8,
                      ),
                      Text(
                        'internet street FCAIH helwan university',
                        style: TextStyle(
                          fontSize: SizeConfig.defaultSize * 1.3,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.defaultSize * 0.8,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: kBackground2,
                        maxRadius: SizeConfig.defaultSize * 2,
                        child: Icon(
                          Icons.phone_outlined,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.defaultSize * 0.8,
                      ),
                      Text(
                        '+2001123456789',
                        style: TextStyle(
                          fontSize: SizeConfig.defaultSize * 1.3,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
