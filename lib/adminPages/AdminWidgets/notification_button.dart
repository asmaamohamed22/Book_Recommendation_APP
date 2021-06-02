import 'package:badges/badges.dart';
import 'package:book_recommend/adminPages/viewFeedback.dart';
import 'package:book_recommend/providers/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  FeedbackProvider feedbackProvider;

  @override
  Widget build(BuildContext context) {
    feedbackProvider = Provider.of<FeedbackProvider>(context);
    return Badge(
      position: BadgePosition(start: 25, top: 8),
      badgeContent: Text(
        feedbackProvider.count.toString(),
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      badgeColor: Colors.red,
      child: IconButton(
        icon: Icon(
          Icons.notifications_none,
          color: Theme.of(context).backgroundColor,
          size: 35,
        ),
        onPressed: () {
          Navigator.pushReplacementNamed(context, ViewFeedback.id);
        },
      ),
    );
  }
}
