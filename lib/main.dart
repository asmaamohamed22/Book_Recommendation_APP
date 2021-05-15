import 'package:book_recommend/adminPages/Dashboard.dart';
import 'package:book_recommend/adminPages/addBook.dart';
import 'package:book_recommend/adminPages/adminMode.dart';
import 'package:book_recommend/adminPages/bookDetails.dart';
import 'package:book_recommend/adminPages/editBook.dart';
import 'package:book_recommend/adminPages/viewBook.dart';
import 'package:book_recommend/adminPages/viewFeedback.dart';
import 'package:book_recommend/providers/notification_provider.dart';
import 'package:book_recommend/providers/provider.dart';
import 'package:book_recommend/providers/theme_provider.dart';
import 'package:book_recommend/screens/about.dart';
import 'package:book_recommend/screens/chat/chatScreen.dart';
import 'package:book_recommend/screens/contactus.dart';
import 'package:book_recommend/screens/details.dart';
import 'package:book_recommend/screens/favorite.dart';
import 'package:book_recommend/screens/home.dart';
import 'package:book_recommend/screens/login.dart';
import 'package:book_recommend/screens/profile.dart';
import 'package:book_recommend/screens/register.dart';
import 'package:book_recommend/screens/reset.dart';
import 'package:book_recommend/screens/saved.dart';
import 'package:book_recommend/screens/skip.dart';
import 'package:book_recommend/screens/splash.dart';
import 'package:book_recommend/screens/welcome.dart';
import 'package:book_recommend/setting/darkmode.dart';
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

final navigatorKey = GlobalKey<NavigatorState>();

class MyBook extends StatelessWidget {
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
          ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider(),
          ),
        ],
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            navigatorKey: navigatorKey,
            title: 'Book',
            themeMode: themeProvider.themeMode,
            darkTheme: MyThemes.darkTheme,
            debugShowCheckedModeBanner: false,
            theme: MyThemes.lightTheme,
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
              Details.id: (context) => Details(),
              ProfileScreen.id: (context) => ProfileScreen(),
              Favorite.id: (context) => Favorite(),
              ChatScreen.id: (context) => ChatScreen(),
              AboutScreen.id: (context) => AboutScreen(),
              ContactUs.id: (context) => ContactUs(),
              Save.id: (context) => Save(),
              Favorite.id: (context) => Favorite(),
              Setting.id: (context) => Setting(),
              ManagePassword.id: (context) => ManagePassword(),
              ResetPassword.id: (context) => ResetPassword(),
              Dashboard.id: (context) => Dashboard(),
              AddBook.id: (context) => AddBook(),
              EditBook.id: (context) => EditBook(),
              ViewBook.id: (context) => ViewBook(),
              BookDetails.id: (context) => BookDetails(),
              ViewFeedback.id: (context) => ViewFeedback(),
              DarkMode.id: (context) => DarkMode(),
              AdminMode.id: (context) => AdminMode(),
            },
          );
        });
  }
}
