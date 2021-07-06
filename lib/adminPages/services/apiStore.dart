import 'dart:async';
import 'package:book_recommend/models/apibookmodel.dart';
import 'package:book_recommend/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ApiStore {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  addBook(Apibook book) async {
    await _firestore.collection(kBooksCollection).add({
      kBookIsbn: book.isbn.toString(),
      kBookImage: book.imageUrlL,
      kBookTitle: book.bookTitle,
      kBookAuthor: book.bookAuthor,
      kBookYearOfPublication: book.yearOfPublication.toString(),
      kBookPublisher: book.publisher,
    });
  }

  Stream<QuerySnapshot> loadBook() {
    return _firestore.collection(kBooksCollection).snapshots();
  }

  Future<DocumentSnapshot> getSingleBook({@required String bookId}) async {
    print("book id >>>> $bookId");
    DocumentSnapshot bookData =
        await _firestore.collection(kBooksCollection).doc(bookId).get();

    return bookData;
  }

  deleteBook(documentId) async {
    await _firestore.collection(kBooksCollection).doc(documentId).delete();
  }

  editBook(data, documentId) async {
    await _firestore.collection(kBooksCollection).doc(documentId).update(data);
  }

  addBookToSaveList({
    @required String bookIsbn,
    @required String bookTitle,
    @required String bookImage,
    @required String bookAuthor,
    @required String bookPublisher,
    @required String bookYearOfPublication,
    String userSaveId,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    _firestore.collection("SaveList").add({
      "createdAt": Timestamp.now(),
      "bookIsbn": bookIsbn,
      "bookTitle": bookTitle,
      "bookImage": bookImage,
      "bookAuthor": bookAuthor,
      "bookPublisher": bookPublisher,
      "bookYearOfPublication": bookYearOfPublication,
      "userSaveId": user.uid,
    });
  }

  Stream<QuerySnapshot> loadSaveBooks() {
    return _firestore
        .collection("SaveList")
        .orderBy("createdAt", descending: true)
        .snapshots();
  }

  Future<QuerySnapshot> getAllSaves() {
    return _firestore.collection("SaveList").get();
  }

  deleteSavedBook(documentId) async {
    await _firestore.collection("SaveList").doc(documentId).delete();
  }

  addBookToFavoriteList({
    @required String bookIsbn,
    @required String bookTitle,
    @required String bookImage,
    @required String bookAuthor,
    @required String bookPublisher,
    @required String bookYearOfPublication,
    String userFavoriteId,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    _firestore.collection("FavoriteList").add({
      "createdAt": Timestamp.now(),
      "bookIsbn": bookIsbn,
      "bookTitle": bookTitle,
      "bookImage": bookImage,
      "bookAuthor": bookAuthor,
      "bookPublisher": bookPublisher,
      "bookYearOfPublication": bookYearOfPublication,
      "userFavoriteId": user.uid,
    });
  }

  Stream<QuerySnapshot> loadFavoriteBooks() {
    return _firestore
        .collection("FavoriteList")
        .orderBy("createdAt", descending: true)
        .snapshots();
  }

  Future<QuerySnapshot> getAllFavorites() {
    return _firestore.collection("FavoriteList").get();
  }

  deleteFavoriteBook(documentId) async {
    await _firestore.collection("FavoriteList").doc(documentId).delete();
  }

  Stream<QuerySnapshot> loadInterestBooks() {
    return _firestore.collection("Interest").snapshots();
  }

  //just to test something
  Future<List<String>> loadInterestBooks2() async {
    List<String> bookNames = [];
    var stream = await _firestore.collection("Interest").get();
    for (var test in stream.docs) {
      bookNames.add(test.data()[bookName]);
      //print(test.data()[bookName] + " inside book2");
    }
    return bookNames;
  }
}
