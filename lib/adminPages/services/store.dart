import 'dart:async';
import 'package:book_recommend/adminPages/models/book.dart';
import 'package:book_recommend/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Store {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  addBook(Book book) async {
    await _firestore.collection(kBooksCollection).add({
      kBookIsbn: book.bIsbn,
      kBookImage: book.bImage,
      kBookTitle: book.bTitle,
      kBookDescription: book.bDescription,
      kBookCategory: book.bCategory,
      kBookAuthor: book.bAuthor,
      kBookYearOfPublication: book.byear_of_publication,
      kBookLanguage: book.bLanguage,
      kBookPublisher: book.bPublisher,
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
    @required String bookDescription,
    @required String bookAuthor,
    @required String bookCategory,
    @required String bookLanguage,
    @required String bookPublisher,
    @required String bookYearOfPublication,
  }) async {
    _firestore.collection("SaveList").add({
      "createdAt": Timestamp.now(),
      "bookIsbn": bookIsbn,
      "bookTitle": bookTitle,
      "bookImage": bookImage,
      "bookDescription": bookDescription,
      "bookAuthor": bookAuthor,
      "bookCategory": bookCategory,
      "bookLanguage": bookLanguage,
      "bookPublisher": bookPublisher,
      "bookYearOfPublication": bookYearOfPublication,
    });
  }

  Stream<QuerySnapshot> loadSaveBooks() {
    return _firestore
        .collection("SaveList")
        .orderBy("createdAt", descending: true)
        .snapshots();
  }

  deleteSavedBook(documentId) async {
    await _firestore.collection("SaveList").doc(documentId).delete();
  }

  addBookToFavoriteList({
    @required String bookIsbn,
    @required String bookTitle,
    @required String bookImage,
    @required String bookDescription,
    @required String bookAuthor,
    @required String bookCategory,
    @required String bookLanguage,
    @required String bookPublisher,
    @required String bookYearOfPublication,
  }) async {
    _firestore.collection("FavoriteList").add({
      "createdAt": Timestamp.now(),
      "bookIsbn": bookIsbn,
      "bookTitle": bookTitle,
      "bookImage": bookImage,
      "bookDescription": bookDescription,
      "bookAuthor": bookAuthor,
      "bookCategory": bookCategory,
      "bookLanguage": bookLanguage,
      "bookPublisher": bookPublisher,
      "bookYearOfPublication": bookYearOfPublication,
    });
  }

  Stream<QuerySnapshot> loadFavoriteBooks() {
    return _firestore
        .collection("FavoriteList")
        .orderBy("createdAt", descending: true)
        .snapshots();
  }

  deleteFavoriteBook(documentId) async {
    await _firestore.collection("FavoriteList").doc(documentId).delete();
  }
}
