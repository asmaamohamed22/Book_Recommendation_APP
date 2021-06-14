import 'package:book_recommend/onBoarding/config/size_config.dart';
import 'package:book_recommend/screens/home.dart';
import 'package:book_recommend/setting/Style/components/z_animated_toggle.dart';
import 'package:book_recommend/setting/Style/models_providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static String id = 'HomePage';
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    super.initState();
  }

  // function to toggle circle animation
  changeThemeMode(bool theme) {
    if (!theme) {
      _animationController.forward(from: 0.0);
    } else {
      _animationController.reverse(from: 1.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // Now we have access to the theme properties
    final themeProvider = Provider.of<ThemeProvider>(context);
    SizeConfig().init(context);
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, HomeScreen.id);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 30,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: height * 0.1),
              child: ListView(
                children: [
                  Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: width * 0.35,
                            height: width * 0.35,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                  colors: themeProvider.themeMode().gradient,
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight),
                            ),
                          ),
                          Transform.translate(
                            offset: Offset(40, 0),
                            child: ScaleTransition(
                              scale: _animationController.drive(
                                Tween<double>(begin: 0.0, end: 1.0).chain(
                                  CurveTween(curve: Curves.decelerate),
                                ),
                              ),
                              alignment: Alignment.topRight,
                              child: Container(
                                width: width * .26,
                                height: width * .26,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: themeProvider.isLightTheme
                                        ? Colors.white
                                        : Color(0xFF26242e)),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: height * 0.1),
                      Text(
                        'Choose a style',
                        style: TextStyle(
                            fontSize: width * .08, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: height * 0.03),
                      Container(
                        width: width * .6,
                        child: Text(
                          'Pop or subtle. Day or night. Customize your interface',
                          style: TextStyle(fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: height * 0.1),
                      ZAnimatedToggle(
                        values: ['Light', 'Dark'],
                        onToggleCallback: (v) async {
                          await themeProvider.toggleThemeData();
                          setState(() {});
                          changeThemeMode(themeProvider.isLightTheme);
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: SizeConfig.defaultSize * 3,
                          bottom: SizeConfig.defaultSize * 2,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            buildDot(
                              width: width * 0.022,
                              height: width * 0.022,
                              color: const Color(0xFFd9d9d9),
                            ),
                            buildDot(
                              width: width * 0.055,
                              height: width * 0.022,
                              color: themeProvider.isLightTheme
                                  ? Color(0xFF26242e)
                                  : Colors.white,
                            ),
                            buildDot(
                              width: width * 0.022,
                              height: width * 0.022,
                              color: const Color(0xFFd9d9d9),
                            ),
                          ],
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

// for drawing the dots
  Container buildDot({double width, double height, Color color}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      width: width,
      height: height,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: color,
      ),
    );
  }
}

// #time for finishing touches! I
