import 'package:book_recommend/adminPages/models/intersetBook.dart';
import 'package:book_recommend/interests/userinterest.dart';
import 'package:book_recommend/models/apibookmodel.dart';
import 'package:book_recommend/constant.dart';
import 'package:book_recommend/onBoarding/config/size_config.dart';
import 'package:book_recommend/setting/Style/models_providers/theme_provider.dart';
import 'package:book_recommend/widgets/mybutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_recommend/screens/Search.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:book_recommend/adminPages/services/apiStore.dart';

class SearchDetails extends StatefulWidget {
  static String id = 'ApiDetail';
  final Apibook book;
  SearchDetails(this.book);
  @override
  _SearchDetailsState createState() => _SearchDetailsState();
}

class _SearchDetailsState extends State<SearchDetails> {
  void initState() {
    super.initState();
    getAllFave();
    getAllInterest();
    getAllSave();
  }

  List<Map<String, dynamic>> allBooksToFav = [];

  void getAllFave() async {
    QuerySnapshot snapShot = await _store.getAllFavorites();

    List<QueryDocumentSnapshot> allBooksInFav = snapShot.docs;

    allBooksInFav.forEach((element) {
      print("=-=-=-=-=> ${element.data().toString()}");
      setState(() {
        allBooksToFav.add(element.data());
      });
    });
  }

  List<Map<String, dynamic>> allBooksToSave = [];
  void getAllSave() async {
    QuerySnapshot snapShot = await _store.getAllSaves();

    List<QueryDocumentSnapshot> allBooksInSave = snapShot.docs;

    allBooksInSave.forEach((element) {
      print("=-=-=-=-=> ${element.data().toString()}");
      setState(() {
        allBooksToSave.add(element.data());
      });
    });
  }

  List<Map<String, dynamic>> allBooksToInterest = [];

  void getAllInterest() async {
    QuerySnapshot snapShot = await _userInterest.getAllInterests();

    List<QueryDocumentSnapshot> allBooksInInterest = snapShot.docs;

    allBooksInInterest.forEach((element) {
      print("=-=-=-=-=> ${element.data().toString()}");
      setState(() {
        allBooksToInterest.add(element.data());
      });
    });
  }

  final _userInterest = UserInterest();
  Interest interest;
  final _store = ApiStore();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    Size size = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: size.height * 0.5,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.book.imageUrlL),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          maxRadius: 25,
                          backgroundColor: themeProvider.isLightTheme
                              ? Colors.white
                              : Color(0xFF26242e),
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: kBackground2,
                              size: 35,
                            ),
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, SearchScreen.id);
                            },
                          ),
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: themeProvider.isLightTheme
                                  ? Colors.white
                                  : Color(0xFF26242e),
                              child: IconButton(
                                icon: Icon(
                                  Icons.save_outlined,
                                  size: 30,
                                  color: Colors.grey[800],
                                ),
                                onPressed: () {
                                  int bookIndex = allBooksToSave.indexWhere(
                                      (element) =>
                                          element["bookTitle"] ==
                                          widget.book.bookTitle);
                                  if (bookIndex != -1) {
                                    _scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                        content: Text("This Book aleady saved"),
                                      ),
                                    );
                                  } else {
                                    _store
                                        .addBookToSaveList(
                                      bookIsbn: widget.book.isbn.toString(),
                                      bookTitle: widget.book.bookTitle,
                                      bookImage: widget.book.imageUrlL,
                                      bookAuthor: widget.book.bookAuthor,
                                      bookPublisher: widget.book.publisher,
                                      bookYearOfPublication: widget
                                          .book.yearOfPublication
                                          .toString(),
                                    )
                                        .then((value) {
                                      _scaffoldKey.currentState.showSnackBar(
                                        SnackBar(
                                          content:
                                              Text("Book Saved Successfully"),
                                        ),
                                      );
                                    });
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: themeProvider.isLightTheme
                                  ? Colors.white
                                  : Color(0xFF26242e),
                              child: IconButton(
                                icon: Icon(
                                  Icons.favorite_outline,
                                  color: Colors.redAccent,
                                  size: 30,
                                ),
                                onPressed: () {
                                  int bookIndex = allBooksToFav.indexWhere(
                                      (element) =>
                                          element["bookTitle"] ==
                                          widget.book.bookTitle);
                                  if (bookIndex != -1) {
                                    _scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            "Book already in favorite list"),
                                      ),
                                    );
                                  } else {
                                    _store
                                        .addBookToFavoriteList(
                                      bookIsbn: widget.book.isbn.toString(),
                                      bookTitle: widget.book.bookTitle,
                                      bookImage: widget.book.imageUrlL,
                                      bookAuthor: widget.book.bookAuthor,
                                      bookPublisher: widget.book.publisher,
                                      bookYearOfPublication: widget
                                          .book.yearOfPublication
                                          .toString(),
                                    )
                                        .then((value) {
                                      _scaffoldKey.currentState.showSnackBar(
                                        SnackBar(
                                          content:
                                              Text("Book Added Successfully"),
                                        ),
                                      );
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: size.height * 0.45),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: themeProvider.isLightTheme
                      ? Colors.white
                      : Color(0xFF26242e),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        child: Container(
                          width: 150,
                          height: 7,
                          decoration: BoxDecoration(
                            color: kBackground2,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 65,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(widget.book.imageUrlS),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.book.bookTitle,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                widget.book.bookAuthor,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            'ISBN :',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.book.isbn.toString(),
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            'Year Of Publication :',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.book.yearOfPublication.toString(),
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            'Publisher :',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.book.publisher,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            'Language :',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'English',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.defaultSize * 2,
                      ),
                      MyButton(
                        name: 'Interest',
                        onPressed: () {
                          int bookIndex = allBooksToInterest.indexWhere(
                              (element) =>
                                  element["bookName"] == widget.book.bookTitle);
                          if (bookIndex != -1) {
                            _scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                content: Text("This Book already added"),
                              ),
                            );
                          } else {
                            _userInterest
                                .addUserInterests(
                              bookName: widget.book.bookTitle,
                            )
                                .then((value) {
                              _scaffoldKey.currentState.showSnackBar(
                                SnackBar(
                                  content: Text("Book added Successfully"),
                                ),
                              );
                            });
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
