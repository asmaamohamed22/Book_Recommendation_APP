import 'package:book_recommend/adminPages/adminhome.dart';
import 'package:book_recommend/constant.dart';
import 'package:book_recommend/providers/provider.dart';
import 'package:book_recommend/screens/about.dart';
import 'package:book_recommend/screens/contactus.dart';
import 'package:book_recommend/screens/home.dart';
import 'package:book_recommend/screens/login.dart';
import 'package:book_recommend/screens/profile.dart';
import 'package:book_recommend/screens/register.dart';
import 'package:book_recommend/screens/skip.dart';
import 'package:book_recommend/screens/splash.dart';
import 'package:book_recommend/screens/welcome.dart';
import 'package:book_recommend/setting/managePassword.dart';
import 'package:book_recommend/setting/setting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebase_core.Firebase.initializeApp();
  runApp(MyBook());
}

class MyBook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BookProvider>(
          create: (context) => BookProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Book',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          primaryColor: kBackground2,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HomeScreen();
            } else {
              return Splash();
            }
          },
        ),
        routes: {
          Splash.id: (context) => Splash(),
          SkipScreen.id: (context) => SkipScreen(),
          WelcomeScreen.id: (context) => WelcomeScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegisterScreen.id: (context) => RegisterScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          ProfileScreen.id: (context) => ProfileScreen(),
          AboutScreen.id: (context) => AboutScreen(),
          ContactUs.id: (context) => ContactUs(),
          Setting.id: (context) => Setting(),
          AdminHome.id: (context) => AdminHome(),
          ManagePassword.id: (context) => ManagePassword(),
        },
      ),
    );
  }
}
