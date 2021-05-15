import 'package:book_recommend/constant.dart';
import 'package:book_recommend/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:book_recommend/adminPages/addBook.dart';
import 'package:book_recommend/adminPages/adminMode.dart';
import 'package:book_recommend/adminPages/viewBook.dart';
import 'package:book_recommend/adminPages/viewFeedback.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:book_recommend/screens/login.dart';

class GridDashboard extends StatefulWidget {
  @override
  _GridDashboardState createState() => _GridDashboardState();
}

class _GridDashboardState extends State<GridDashboard> {
  @override
  Widget build(BuildContext context) {
    Items item1 = new Items(
      title: "Add Book",
      subtitle: "➕",
      onPressed: () {
        Navigator.pushReplacementNamed(context, AddBook.id);
      },
    );

    Items item2 = new Items(
      title: "View Book",
      subtitle: "📖",
      onPressed: () {
        Navigator.pushReplacementNamed(context, ViewBook.id);
      },
    );

    Items item3 = new Items(
      title: "View Feedback",
      subtitle: "💬",
      onPressed: () {
        Navigator.pushReplacementNamed(context, ViewFeedback.id);
      },
    );

    Items item4 = new Items(
      title: "Generate Report",
      subtitle: "📝",
      onPressed: () {
        //Navigator.pushReplacementNamed(context, HomeScreen.id);
      },
    );

    Items item5 = new Items(
      title: "Settings",
      subtitle: "🔆",
      onPressed: () {
        Navigator.pushReplacementNamed(context, AdminMode.id);
      },
    );

    Items item6 = new Items(
      title: "Logout",
      subtitle: "✖️",
      onPressed: () async {
        await FirebaseAuth.instance.signOut().then((value) {
          Navigator.pushReplacementNamed(context, LoginScreen.id);
        });
      },
    );

    List<Items> myList = [item1, item2, item3, item4, item5, item6];
    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {
            return GestureDetector(
              onTap: data.onPressed,
              child: Container(
                decoration: BoxDecoration(
                    color: kBackground2,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data.subtitle,
                      style: TextStyle(
                        fontSize: 35,
                      ),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      data.title,
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            );
          }).toList()),
    );
  }
}

class Items {
  String title;
  String subtitle;
  Function onPressed;
  Items({this.title, this.subtitle, this.onPressed});
}
