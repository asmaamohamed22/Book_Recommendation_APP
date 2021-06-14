import 'package:book_recommend/adminPages/AdminWidgets/gridDashboard.dart';
import 'package:book_recommend/adminPages/AdminWidgets/notification_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Dashboard extends StatefulWidget {
  static String id = 'Dashboard';
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.09,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dashboard',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 27,
                          fontFamily: 'pacifico'),
                    ),
                    SizedBox(
                      height: size.height * 0.001,
                    ),
                    Text(
                      'Home',
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Notifications(),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.04,
          ),
          GridDashboard(),
        ],
      ),
    );
  }
}
