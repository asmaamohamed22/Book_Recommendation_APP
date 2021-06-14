import 'dart:io';

import 'package:book_recommend/adminPages/Dashboard.dart';
import 'package:book_recommend/adminPages/addBook.dart';
import 'package:book_recommend/adminPages/bookDetails.dart';
import 'package:book_recommend/adminPages/editBook.dart';
import 'package:book_recommend/adminPages/viewBook.dart';
import 'package:book_recommend/adminPages/viewFeedback.dart';
import 'package:book_recommend/onBoarding/onboarding_screen.dart';
import 'package:book_recommend/providers/notification_provider.dart';
import 'package:book_recommend/providers/provider.dart';
import 'package:book_recommend/screens/Recommendation.dart';
import 'package:book_recommend/screens/Search.dart';
import 'package:book_recommend/screens/about.dart';
import 'package:book_recommend/screens/chat/chatScreen.dart';
import 'package:book_recommend/screens/contactus.dart';
import 'package:book_recommend/screens/details.dart';
import 'package:book_recommend/screens/favorite.dart';
import 'package:book_recommend/screens/home.dart';
import 'package:book_recommend/screens/interest.dart';
import 'package:book_recommend/screens/login.dart';
import 'package:book_recommend/screens/profile.dart';
import 'package:book_recommend/screens/register.dart';
import 'package:book_recommend/screens/reset.dart';
import 'package:book_recommend/screens/saved.dart';
import 'package:book_recommend/screens/splash.dart';
import 'package:book_recommend/screens/welcome.dart';
import 'package:book_recommend/setting/Style/models_providers/theme_provider.dart';
import 'package:book_recommend/setting/Style/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

void main() async {
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await firebase_core.Firebase.initializeApp();
  final appDocumentDirectory =
      await pathProvider.getApplicationDocumentsDirectory();

  Hive.init(appDocumentDirectory.path);

  final settings = await Hive.openBox('settings');
  bool isLightTheme = settings.get('isLightTheme') ?? true;

  print(isLightTheme);
  runApp(ChangeNotifierProvider(
    create: (_) => ThemeProvider(isLightTheme: isLightTheme),
    child: AppStart(),
  ));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

final navigatorKey = GlobalKey<NavigatorState>();

class AppStart extends StatelessWidget {
  const AppStart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return MyBook(
      themeProvider: themeProvider,
    );
  }
}

class MyBook extends StatefulWidget with WidgetsBindingObserver {
  final ThemeProvider themeProvider;

  const MyBook({Key key, this.themeProvider}) : super(key: key);
  @override
  _MyBookState createState() => _MyBookState();
}

class _MyBookState extends State<MyBook> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<BookProvider>(
            create: (context) => BookProvider(),
          ),
          ChangeNotifierProvider<FeedbackProvider>(
            create: (context) => FeedbackProvider(),
          ),
        ],
        builder: (context, _) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            title: 'Book',
            debugShowCheckedModeBanner: false,
            theme: widget.themeProvider.themeData(),
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
              OnboardingScreen.id: (context) => OnboardingScreen(),
              WelcomeScreen.id: (context) => WelcomeScreen(),
              LoginScreen.id: (context) => LoginScreen(),
              RegisterScreen.id: (context) => RegisterScreen(),
              HomeScreen.id: (context) => HomeScreen(),
              Details.id: (context) => Details(),
              ProfileScreen.id: (context) => ProfileScreen(),
              Favorite.id: (context) => Favorite(),
              ChatScreen.id: (context) => ChatScreen(),
              AboutScreen.id: (context) => AboutScreen(),
              ContactUs.id: (context) => ContactUs(),
              Save.id: (context) => Save(),
              Favorite.id: (context) => Favorite(),
              ResetPassword.id: (context) => ResetPassword(),
              Dashboard.id: (context) => Dashboard(),
              AddBook.id: (context) => AddBook(),
              EditBook.id: (context) => EditBook(),
              ViewBook.id: (context) => ViewBook(),
              BookDetails.id: (context) => BookDetails(),
              ViewFeedback.id: (context) => ViewFeedback(),
              Recommendation.id: (context) => Recommendation(),
              SearchScreen.id: (context) => SearchScreen(),
              InterestBook.id: (context) => InterestBook(),
              HomePage.id: (context) => HomePage(),
            },
          );
        });
  }
}
