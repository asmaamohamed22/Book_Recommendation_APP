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
}
