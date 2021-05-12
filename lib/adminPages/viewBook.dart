import 'package:book_recommend/adminPages/bookDetails.dart';
import 'package:book_recommend/adminPages/models/book.dart';
import 'package:book_recommend/adminPages/services/store.dart';
import 'package:book_recommend/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:book_recommend/adminPages/Dashboard.dart';

class ViewBook extends StatefulWidget {
  static String id = 'ViewBook';
  @override
  _ViewBookState createState() => _ViewBookState();
}

class _ViewBookState extends State<ViewBook> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _store = Store();
  Book book;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, Dashboard.id);
          },
          icon: Icon(
            Icons.arrow_back,
            color: kBackground2,
            size: 35,
          ),
        ),
        centerTitle: true,
        title: Text(
          '📚 Books',
          style: TextStyle(
            color: kBackground2,
            fontSize: 25,
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _store.loadBook(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Book> books = [];
              for (var doc in snapshot.data.docs) {
                var data = doc.data();
                books.add(Book(
                  bId: doc.id,
                  bImage: data[kBookImage],
                  bTitle: data[kBookTitle],
                  bDescription: data[kBookDescription],
                  bPublisher: data[kBookPublisher],
                  bAuthor: data[kBookAuthor],
                  bCategory: data[kBookCategory],
                  bIsbn: data[kBookIsbn],
                  byear_of_publication: data[kBookYearOfPublication],
                  bLanguage: data[kBookLanguage],
                ));
              }
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.7),
                itemBuilder: (context, index) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, BookDetails.id,
                          arguments: books[index]);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: books[index].bImage == null
                                ? Container()
                                : Image(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(books[index].bImage),
                                  ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 60,
                              color: Colors.black87,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      books[index].bTitle,
                                      style: TextStyle(
                                        color: kBackground2,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      books[index].bAuthor,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                itemCount: books.length,
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
