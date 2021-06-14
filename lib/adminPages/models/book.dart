import 'package:flutter/material.dart';

class Book {
  String bId;
  String bIsbn;
  String bTitle;
  String bDescription;
  String bAuthor;
  String bAuthorImage;
  String bImage;
  String bLanguage;
  String bPublisher;
  // ignore: non_constant_identifier_names
  String byear_of_publication;
  String userId;

  Book({
    this.bId,
    @required this.bIsbn,
    @required this.bTitle,
    @required this.bDescription,
    @required this.bAuthor,
    @required this.bAuthorImage,
    @required this.bImage,
    @required this.bLanguage,
    @required this.bPublisher,
    // ignore: non_constant_identifier_names
    @required this.byear_of_publication,
    this.userId,
  });
}
