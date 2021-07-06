// To parse this JSON data, do
//
//     final apibook = apibookFromJson(jsonString);

import 'dart:convert';

List<Apibook> apibookFromJson(String str) =>
    List<Apibook>.from(json.decode(str).map((x) => Apibook.fromJson(x)));

String apibookToJson(List<Apibook> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Apibook {
  Apibook({
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

  factory Apibook.fromJson(Map<String, dynamic> json) => Apibook(
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
