import 'package:flutter/material.dart';

class FeedbackProvider with ChangeNotifier {
  int _count = 0;
  List<String> notificationList = [];

  void addCount() {
    _count++;
    notifyListeners();
  }

  int get count {
    return _count;
  }

  void addNotification(String notification) {
    notificationList.add(notification);
  }

  int get getNotificationIndex {
    return notificationList.length;
  }

  get getNotificationList {
    return notificationList;
  }
}
