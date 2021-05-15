import 'package:book_recommend/adminPages/models/book.dart';
import 'package:book_recommend/adminPages/services/store.dart';
import 'package:book_recommend/constant.dart';
import 'package:book_recommend/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  static String id = 'Details';
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  void initState() {
    super.initState();
  }

  Book book;
  Store _store = Store();
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    Size size = MediaQuery.of(context).size;
    Book book = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
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
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: IconButton(
                                icon: Icon(
                                  Icons.save,
                                  size: 30,
                                  color: kBackground2,
                                ),
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            CircleAvatar(
                              radius: 25,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: IconButton(
                                icon: Icon(
                                  Icons.favorite_outline,
                                  color: kBackground2,
                                  size: 30,
                                ),
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(
                              width: 20,
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
                  color: Theme.of(context).scaffoldBackgroundColor,
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
                                image: NetworkImage(book.bImage),
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
                                  color: Theme.of(context).backgroundColor,
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
                              color: Theme.of(context).backgroundColor,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            book.bIsbn,
                            style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).backgroundColor,
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
                              color: Theme.of(context).backgroundColor,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            book.byear_of_publication,
                            style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).backgroundColor,
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
                              color: Theme.of(context).backgroundColor,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            book.bPublisher,
                            style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).backgroundColor,
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
                              color: Theme.of(context).backgroundColor,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            book.bLanguage,
                            style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).backgroundColor,
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
                            'Category :',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).backgroundColor,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            book.bCategory,
                            style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).backgroundColor,
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
