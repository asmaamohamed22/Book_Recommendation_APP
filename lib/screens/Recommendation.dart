import 'package:book_recommend/adminPages/services/store.dart';
import 'package:book_recommend/setting/Style/models_providers/theme_provider.dart';
import 'package:book_recommend/widgets/mybutton.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:book_recommend/constant.dart';
import 'package:book_recommend/screens/home.dart';
import 'package:provider/provider.dart';

class Recommendation extends StatefulWidget {
  static String id = 'Recommendation';

  @override
  _RecommendationState createState() => _RecommendationState();
}

class _RecommendationState extends State<Recommendation> {
  int bookcount;
  var jsonresponse;
  String bookname;
  String queryDec;
  int count = 0;
  Future<void> callUri(decString) async {
    print("hello fro calURI");
    print(decString);
    http.Response response = await http.get(
      Uri.https(
        '192.168.1.5:5000',
        "/api/get_rec",
        {'books': "{$decString}"},
      ),
    );
    if (response.statusCode == 200) {
      setState(() {
        jsonresponse = jsonDecode(response.body);
        bookcount = jsonresponse.length;
      });
    } else {
      print("Request failed with status: ${response.statusCode}");
    }
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

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    // final _store = Store();
    // Interest interest;
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            themeProvider.isLightTheme ? Colors.white : Color(0xFF26242e),
        title: Text(
          'Recommendation',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: MyButton(
                    name: 'Get Books',
                    onPressed: () {
                      setState(() {
                        getBooks();
                        bookcount = null;
                      });
                    },
                  ),
                ),
                SizedBox(height: 60),
                Container(
                  height: bookcount == null ? 50 : 400,
                  child: bookcount == null
                      ? Text("Loading books...")
                      : ListView.builder(
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(
                                    jsonresponse[index]["imageUrlL"]),
                              ),
                              title: Text(
                                jsonresponse[index]["bookTitle"],
                                style: TextStyle(fontSize: 25),
                              ),
                            );
                          },
                          itemCount: bookcount,
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
