import 'package:flutter/material.dart';

class UserModel {
  String userName, userEmail, userPhoneNumber, userImage, userPassword;
  UserModel({
    @required this.userName,
    @required this.userEmail,
    @required this.userPassword,
    @required this.userPhoneNumber,
    @required this.userImage,
  });
}
