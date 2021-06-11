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
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, HomeScreen.id);
          },
          icon: Icon(
            Icons.arrow_back,
            color: kBackground2,
            size: 35,
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                        fontSize: 35,
                        color: kBackground2,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/icons/backlogo.png',
                      width: 250,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Who we are ?',
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Theme.of(context).backgroundColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Text(
                    'Recme is book recommendation app',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Theme.of(context).backgroundColor,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Text(
                    'Since 2021 we make people happy with our services ,This app you can get on all recommendation book that you want to be recommended for you.',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Theme.of(context).backgroundColor,
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
                          color: Theme.of(context).backgroundColor,
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
                          color: Theme.of(context).backgroundColor,
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
                          color: Theme.of(context).backgroundColor,
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
