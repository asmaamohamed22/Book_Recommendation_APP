import 'dart:ui';
import 'package:book_recommend/constant.dart';
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, HomeScreen.id);
          },
          icon: Icon(
            Icons.arrow_back,
            color: kBackground2,
            size: 35,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      "About",
                      style: TextStyle(
                        fontSize: 40,
                        color: kBackground2,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/kingicon.png',
                      height: 180.0,
                      width: 180.0,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    'Who we are ?',
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Text(
                    'Book Recommendation App',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Text(
                    'Since 2020 we make people happy with our services,This app you can get on all recommendation book that you like to read it.',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: kBackground2,
                        maxRadius: 25,
                        child: Icon(
                          Icons.email_outlined,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                      Text(
                        'developers_team@gmail.com',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: kBackground2,
                        maxRadius: 25,
                        child: Icon(
                          Icons.home_outlined,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                      Text(
                        'internet street FCAIH helwan university',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: kBackground2,
                        maxRadius: 25,
                        child: Icon(
                          Icons.phone_outlined,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                      Text(
                        '+2001123456789',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
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
