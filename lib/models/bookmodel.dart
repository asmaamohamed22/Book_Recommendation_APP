// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

List<Book> bookFromJson(String str) =>
    List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

String bookToJson(List<Book> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Book {
  Book({
    this.isbn,
    this.bookAuthor,
    this.bookTitle,
    this.imageUrlL,
    this.imageUrlM,
    this.imageUrlS,
    this.publisher,
    this.yearOfPublication,
  });

  String isbn;
  String bookAuthor;
  String bookTitle;
  String imageUrlL;
  String imageUrlM;
  String imageUrlS;
  String publisher;
  dynamic yearOfPublication;

  factory Book.fromJson(Map<String, dynamic> json) => Book(
    isbn: json["ISBN"],
    bookAuthor: json["bookAuthor"],
    bookTitle: json["bookTitle"],
    imageUrlL: json["imageUrlL"],
    imageUrlM: json["imageUrlM"],
    imageUrlS: json["imageUrlS"],
    publisher: json["publisher"],
    yearOfPublication: json["yearOfPublication"],
  );

  Map<String, dynamic> toJson() => {
    "ISBN": isbn,
    "bookAuthor": bookAuthor,
    "bookTitle": bookTitle,
    "imageUrlL": imageUrlL,
    "imageUrlM": imageUrlM,
    "imageUrlS": imageUrlS,
    "publisher": publisher,
    "yearOfPublication": yearOfPublication,
  };
}
