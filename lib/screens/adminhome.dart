import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _scaffoldKey,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Theme.of(context).primaryColor,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.notifications_none,
                              size: 30,
                            ),
                            onPressed: () {},
                          ),
                          Text(
                            'Admin Home',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'pacifico',
                              fontSize: 25.0,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.logout,
                              size: 30,
                            ),
                            onPressed: () async {
                              await FirebaseAuth.instance
                                  .signOut()
                                  .then((value) {
                                Navigator.of(context)
                                    .pushReplacementNamed('login');
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
