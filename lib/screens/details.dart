import 'package:book_recommend/adminPages/models/book.dart';
import 'package:book_recommend/adminPages/services/store.dart';
import 'package:book_recommend/constant.dart';
import 'package:book_recommend/screens/home.dart';
import 'package:book_recommend/setting/Style/models_providers/theme_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Details extends StatefulWidget {
  static String id = 'Details';
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  void initState() {
    super.initState();
    getAllFave();
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

  Book book;
  final _store = Store();
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    Size size = MediaQuery.of(context).size;
    Book book = ModalRoute.of(context).settings.arguments;
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
                    image: NetworkImage(book.bImage),
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
                                  context, HomeScreen.id);
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
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  int bookIndex = allBooksToSave.indexWhere(
                                      (element) =>
                                          element["bookTitle"] == book.bTitle);
                                  if (bookIndex != -1) {
                                    _scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                        content: Text("This Book aleady saved"),
                                      ),
                                    );
                                  } else {
                                    _store
                                        .addBookToSaveList(
                                      bookIsbn: book.bIsbn,
                                      bookTitle: book.bTitle,
                                      bookImage: book.bImage,
                                      bookDescription: book.bDescription,
                                      bookAuthor: book.bAuthor,
                                      bookPublisher: book.bPublisher,
                                      bookAuthorImage: book.bAuthorImage,
                                      bookLanguage: book.bLanguage,
                                      bookYearOfPublication:
                                          book.byear_of_publication,
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
                                          element["bookTitle"] == book.bTitle);
                                  if (bookIndex != -1) {
                                    _scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            "Book already exist in favorite list"),
                                      ),
                                    );
                                  } else {
                                    _store
                                        .addBookToFavoriteList(
                                      bookIsbn: book.bIsbn,
                                      bookTitle: book.bTitle,
                                      bookImage: book.bImage,
                                      bookDescription: book.bDescription,
                                      bookAuthor: book.bAuthor,
                                      bookPublisher: book.bPublisher,
                                      bookAuthorImage: book.bAuthorImage,
                                      bookLanguage: book.bLanguage,
                                      bookYearOfPublication:
                                          book.byear_of_publication,
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
                                image: NetworkImage(book.bAuthorImage),
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
                                book.bTitle,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                book.bAuthor,
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
                      Text(
                        book.bDescription,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(
                        height: 10,
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
                            book.bIsbn,
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
                            book.byear_of_publication,
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
                            book.bPublisher,
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
                            book.bLanguage,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          )
                        ],
                      ),
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
