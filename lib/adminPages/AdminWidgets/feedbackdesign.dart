import 'package:book_recommend/constant.dart';
import 'package:flutter/material.dart';

class AdminContent extends StatelessWidget {
  const AdminContent({
    Key key,
    this.name,
    this.icon,
  }) : super(key: key);
  final String name;
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
              colors: [kBackground2, kBackground1],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
          boxShadow: [
            BoxShadow(
              color: kBackground1,
              blurRadius: 10,
              offset: Offset(0, 6),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            children: [
              icon,
              SizedBox(
                width: 30,
              ),
              Text(
                name,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
