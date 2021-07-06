import 'package:book_recommend/models/apibookmodel.dart';
import 'package:book_recommend/screens/userInterestsDetails.dart';
import 'package:flutter/material.dart';
import 'package:book_recommend/adminPages/services/store.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:book_recommend/constant.dart';

class InterestsBooksInHome extends StatefulWidget {
  static String id = 'InterestsBooksInHome';

  @override
  _InterestsBooksInHomeState createState() => _InterestsBooksInHomeState();
}

class _InterestsBooksInHomeState extends State<InterestsBooksInHome> {
  int bookcount;
  var jsonresponse;
  String bookname;
  String queryDec;
  int count = 0;
  List<Apibook> booklist = new List();
  Future<void> callUri(decString) async {
    List<Apibook> books = [];
    print("hello fro calURI");
    print(decString);
    http.Response response = await http.get(
      Uri.https(
        '192.168.1.4:5000',
        "/api/get_rec",
        {'books': "{$decString}"},
      ),
    );
    if (response.statusCode == 200) {
      setState(() {
        jsonresponse = jsonDecode(response.body);
        bookcount = jsonresponse.length;
      });
      final books = apibookFromJson(response.body);
      setState(() {
        booklist = books;
      });
    } else {
      print("Request failed with status: ${response.statusCode}");
    }

    return books;
  }

  void getBooks() async {
    //List<Book> books = [];
    //String url = "http://10.0.2.2:5000/api/get_rec?books={1:\"$booknamee\"}";
    //creating  a list of book names
    final _store = Store();
    List<String> bookNames = await _store.loadInterestBooks2();
    String decString;
    int counter = 0;
    for (var name in bookNames) {
      print(name + 'inside loop');
      if (counter != 0) {
        decString += ",";
      }
      if (counter == 0) {
        decString = (counter.toString() + ':' + '\"' + name + '\"');
        counter += 1;
      } else {
        decString = decString + (counter.toString() + ':' + '\"' + name + '\"');
        counter += 1;
      }
    }
    print(decString);
    callUri(decString);
  }

  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 0.9,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 1,
          ),
          itemCount: booklist.length,
          // physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) =>
                              UserInterestsDetails(booklist[index])));
                },
                child: Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: booklist[index].imageUrlL == null
                              ? Container()
                              : Image(
                                  fit: BoxFit.fill,
                                  image:
                                      NetworkImage(booklist[index].imageUrlL),
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
                                  horizontal: 7, vertical: 4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    booklist[index].bookTitle,
                                    style: TextStyle(
                                      color: kBackground2,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                  SizedBox(height: 3),
                                  Row(
                                    children: [
                                      Text(
                                        'by ',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                        ),
                                      ),
                                      Text(
                                        booklist[index].bookAuthor,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
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
            );
          }),
    );
  }

  void initState() {
    super.initState();
    getBooks();
  }
}
