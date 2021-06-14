import 'package:badges/badges.dart';
import 'package:book_recommend/constant.dart';
import 'package:book_recommend/providers/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  FeedbackProvider feedbackProvider;
  Future<void> myDialogBox(context) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Alert"),
            actions: [
              FlatButton(
                child: Text(
                  "Clear Notification",
                  style: TextStyle(color: kBackground2),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    feedbackProvider.notificationList.clear();
                  });
                },
              ),
              FlatButton(
                child: Text(
                  "Okey",
                  style: TextStyle(color: kBackground2),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(feedbackProvider.notificationList.isNotEmpty
                      ? "Messages On Way"
                      : "No Messages At Yet"),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    feedbackProvider = Provider.of<FeedbackProvider>(context);
    return Badge(
      position: BadgePosition(start: 25, top: 8),
      badgeContent: Text(
        feedbackProvider.getNotificationIndex.toString(),
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      badgeColor: Colors.red,
      child: IconButton(
        icon: Icon(
          Icons.notifications_none,
          color: Colors.black,
          size: 35,
        ),
        onPressed: () {
          myDialogBox(context);
        },
      ),
    );
  }
}
