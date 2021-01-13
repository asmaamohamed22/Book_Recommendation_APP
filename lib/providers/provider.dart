import 'package:book_recommend/models/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookProvider with ChangeNotifier {
  List<UserModel> userModelList = [];
  UserModel userModel;
  Future<void> getUserData() async {
    List<UserModel> newList = [];
    User currentUser = FirebaseAuth.instance.currentUser;
    QuerySnapshot userSnapShot =
        await FirebaseFirestore.instance.collection('User').get();
    userSnapShot.docs.forEach(
      (element) {
        if (currentUser.uid == element.data()['UserId']) {
          userModel = UserModel(
              userImage: element.data()['UserImage'],
              userName: element.data()['UserName'],
              userEmail: element.data()['UserEmail'],
              userPhoneNumber: element.data()['Phone Number']);
          newList.add(userModel);
        }
        userModelList = newList;
      },
    );
    // notifyListeners();
  }

  List<UserModel> get getUserModelList {
    return userModelList;
  }
}
