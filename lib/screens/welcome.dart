import 'package:book_recommend/constant.dart';
import 'package:book_recommend/onBoarding/config/size_config.dart';
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
    SizeConfig().init(context);
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          height: SizeConfig.defaultSize * 55,
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
                            'assets/skip/Welcome-bro.png',
                            height: SizeConfig.defaultSize * 23,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.defaultSize),
                          child: FadeAnimation(
                            0.7,
                            Text(
                              'Get the best \n recommendation \n for book !',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: SizeConfig.defaultSize * 2.8,
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
                    height: SizeConfig.defaultSize * 3,
                  ),
                  FadeAnimation(
                    1,
                    Text(
                      'Start Your Journey',
                      style: TextStyle(
                          fontSize: SizeConfig.defaultSize * 1.5,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.defaultSize * 1.2,
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
                    height: SizeConfig.defaultSize * 0.6,
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
