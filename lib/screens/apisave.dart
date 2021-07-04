import 'package:book_recommend/adminPages/models/book.dart';
import 'package:book_recommend/adminPages/services/store.dart';
import 'package:book_recommend/constant.dart';
import 'package:book_recommend/onBoarding/config/size_config.dart';
import 'package:book_recommend/providers/provider.dart';
import 'package:book_recommend/screens/home.dart';
import 'package:book_recommend/screens/interestDetails.dart';
import 'package:book_recommend/setting/Style/models_providers/theme_provider.dart';
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
    SizeConfig().init(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor:
            themeProvider.isLightTheme ? Colors.white : Color(0xFF26242e),
        title: Text(
          'Save',
          style: TextStyle(
              color: kBackground2, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, HomeScreen.id);
          },
          icon: Icon(
            Icons.arrow_back,
            color: kBackground2,
            size: 35,
          ),
        ),
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
                    bAuthorImage: data[kBookAuthorImage],
                    bIsbn: data[kBookIsbn],
                    byear_of_publication: data[kBookYearOfPublication],
                    bLanguage: data[kBookLanguage],
                  ));
                }
              }
              return ListView.builder(
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.defaultSize * 1.5,
                      vertical: SizeConfig.defaultSize * 0.6),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, InterestDetails.id,
                          arguments: books[index]);
                    },
                    child: Container(
                      height: SizeConfig.defaultSize * 10,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: themeProvider.isLightTheme
                            ? Colors.white
                            : Color(0xFF26242e),
                        borderRadius: BorderRadius.circular(35),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 5),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: SizeConfig.defaultSize * 9,
                                width: SizeConfig.defaultSize * 8,
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  image: books[index].bImage == null
                                      ? Container()
                                      : DecorationImage(
                                          fit: BoxFit.fill,
                                          image:
                                              NetworkImage(books[index].bImage),
                                        ),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      bottomLeft: Radius.circular(30)),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: SizeConfig.defaultSize * 1,
                                  top: SizeConfig.defaultSize * 2,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      books[index].bTitle,
                                      style: TextStyle(
                                        color: kBackground2,
                                        fontWeight: FontWeight.bold,
                                        fontSize: SizeConfig.defaultSize * 1.3,
                                      ),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.defaultSize * 0.7,
                                    ),
                                    Text(
                                      books[index].bAuthor,
                                      style: TextStyle(
                                        fontSize: SizeConfig.defaultSize * 1.2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.defaultSize * 2,
                                  vertical: SizeConfig.defaultSize * 4,
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.save,
                                    size: 25,
                                    color: Colors.grey[800],
                                  ),
                                  onPressed: () {
                                    _store
                                        .deleteSavedBook(books[index].bId)
                                        .then((value) {
                                      _scaffoldKey.currentState.showSnackBar(
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
