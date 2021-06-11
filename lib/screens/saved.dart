import 'package:book_recommend/adminPages/models/book.dart';
import 'package:book_recommend/adminPages/services/store.dart';
import 'package:book_recommend/constant.dart';
import 'package:book_recommend/providers/provider.dart';
import 'package:book_recommend/screens/details.dart';
import 'package:book_recommend/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Save extends StatefulWidget {
  static String id = 'Save';
  @override
  _SaveState createState() => _SaveState();
}

BookProvider bookProvider;

class _SaveState extends State<Save> {
  final _store = Store();
  Book book;
  void getCallAllFunction() {
    bookProvider.getUserData();
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    bookProvider = Provider.of<BookProvider>(context);
    getCallAllFunction();
    // Size size = MediaQuery.of(context).size;
    //Book book = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Save',
          style: TextStyle(
              color: kBackground2, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, HomeScreen.id);
          },
          icon: Icon(
            Icons.arrow_back,
            color: kBackground2,
            size: 35,
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _store.loadSaveBooks(),
          builder: (context, snapshot) {
            final user = FirebaseAuth.instance.currentUser;
            print("current user id =-=-=> ${user.uid}");
            if (snapshot.hasData) {
              List<Book> books = [];
              for (var doc in snapshot.data.docs) {
                var data = doc.data();
                if (user.uid == data["userSaveId"]) {
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
              }
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 1.5,
                ),
                itemBuilder: (context, index) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Details.id,
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
                                    horizontal: 15, vertical: 4),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          books[index].bTitle,
                                          style: TextStyle(
                                            color: kBackground2,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                          books[index].bAuthor,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 30),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                          size: 30,
                                        ),
                                        onPressed: () {
                                          _store
                                              .deleteSavedBook(books[index].bId)
                                              .then((value) {
                                            _scaffoldKey.currentState
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    "Saved Book deleted successfully"),
                                              ),
                                            );
                                          });
                                        },
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
