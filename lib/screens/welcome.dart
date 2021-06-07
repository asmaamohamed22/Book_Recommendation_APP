import 'package:book_recommend/constant.dart';
import 'package:book_recommend/onBoarding/fade_animation.dart';
import 'package:book_recommend/screens/login.dart';
import 'package:book_recommend/widgets/roundedbutton.dart';
import 'package:book_recommend/widgets/welcomeloginbutton.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'WelcomeScreen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: double.infinity,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        FadeAnimation(
                          0.4,
                          Image.asset(
                            'assets/skip/logo.png',
                            width: size.width * 0.5,
                            height: size.width * 0.4,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.07,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: FadeAnimation(
                            0.7,
                            Text(
                              'Get the best recommendation for book!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 32.0,
                                fontWeight: FontWeight.bold,
                                color: kBackground2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.06,
                  ),
                  FadeAnimation(
                    1,
                    Text(
                      'Start Your Journey',
                      style: TextStyle(
                          fontSize: 18,
                          color: kLightGreyColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  FadeAnimation(
                    1.2,
                    RoundedButton(
                      text: 'Login',
                      press: () {
                        Navigator.pushNamed(context, LoginScreen.id);
                      },
                      color: kBackground2,
                      textColor: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  FadeAnimation(
                    1.5,
                    LoginButton(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
