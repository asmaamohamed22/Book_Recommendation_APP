import 'package:book_recommend/widgets/mybutton.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:book_recommend/constant.dart';
import 'package:book_recommend/screens/home.dart';

class SearchScreen extends StatefulWidget {
  static String id = 'SearchScreen';
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int bookcount;
  var jsonresponse;
  String bookname;
  Future<void> getBooks(booknamee) async {
    //List<Book> books = [];
    String url = "http://10.0.2.2:5000/api/get_rec?books={1:\"$booknamee\"}";
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        jsonresponse = jsonDecode(response.body);
        bookcount = jsonresponse.length;
      });
    } else {
      print("Request failed with status: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Search',
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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.5,
                      color: kBackground1,
                    ),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    autocorrect: true,
                    enableSuggestions: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 18.0, horizontal: 20.0),
                      hintText: "Enter book name",
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.grey[500],
                      ),
                    ),
                    onChanged: (value) {
                      bookname = value;
                    },
                    onSubmitted: (value) {
                      print(value);
                    },
                  ),
                ),
                SizedBox(height: 30),
                MyButton(
                  name: 'Recommend',
                  onPressed: () {
                    getBooks(bookname);
                    setState(() {
                      bookcount = null;
                    });
                  },
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
