import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserInterest {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  addUserInterests({
    @required String bookName,
    String userInterestId,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    _firestore.collection("Interest").add({
      "bookName": bookName,
      "userInterestId": user.uid,
    });
  }

  Future<QuerySnapshot> getAllInterests() {
    return _firestore.collection("Interest").get();
  }
}
