import 'package:book_recommend/adminPages/Dashboard.dart';
import 'package:book_recommend/adminPages/models/book.dart';
import 'package:book_recommend/adminPages/services/store.dart';
import 'package:book_recommend/constant.dart';
import 'package:book_recommend/widgets/mybutton.dart';
import 'package:flutter/material.dart';

class AddBook extends StatefulWidget {
  static String id = 'AddBook';
  @override
  _AddBookState createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _isbn,
      _title,
      _description,
      _author,
      _authorImage,
      // ignore: non_constant_identifier_names
      _year_of_publication,
      _image,
      _language,
      _publisher;
  Book book;
  final _store = Store();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
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
          'Add Book',
          style: TextStyle(
            color: kBackground2,
            fontSize: 25,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          maxRadius: 75,
                          backgroundColor: kBackground2,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            maxRadius: 70,
                            backgroundImage:
                                AssetImage('assets/icons/thisicon.png'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      TextFormField(
                        onSaved: (value) {
                          _image = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Image Is Empty';
                          } else {
                            return null;
                          }
                        },
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Book Image',
                          hintStyle: TextStyle(color: Colors.black45),
                          prefixIcon: Icon(
                            Icons.image,
                            color: kBackground2,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      TextFormField(
                        onSaved: (value) {
                          _isbn = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'ISBN Is Empty';
                          } else {
                            return null;
                          }
                        },
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'ISBN',
                          hintStyle: TextStyle(color: Colors.black45),
                          prefixIcon: Icon(
                            Icons.confirmation_number,
                            color: kBackground2,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      TextFormField(
                        onSaved: (value) {
                          _title = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Title Is Empty';
                          } else {
                            return null;
                          }
                        },
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Title',
                          hintStyle: TextStyle(color: Colors.black45),
                          prefixIcon: Icon(
                            Icons.title,
                            color: kBackground2,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      TextFormField(
                        onSaved: (value) {
                          _description = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Description Is Empty';
                          } else {
                            return null;
                          }
                        },
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Description',
                          hintStyle: TextStyle(color: Colors.black45),
                          prefixIcon: Icon(
                            Icons.description,
                            color: kBackground2,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      TextFormField(
                        onSaved: (value) {
                          _author = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Author Is Empty';
                          } else {
                            return null;
                          }
                        },
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Author',
                          hintStyle: TextStyle(color: Colors.black45),
                          prefixIcon: Icon(
                            Icons.person,
                            color: kBackground2,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      TextFormField(
                        onSaved: (value) {
                          _authorImage = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'AuthorImage Is Empty';
                          } else {
                            return null;
                          }
                        },
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Author Image',
                          hintStyle: TextStyle(color: Colors.black45),
                          prefixIcon: Icon(
                            Icons.image_outlined,
                            color: kBackground2,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      TextFormField(
                        onSaved: (value) {
                          _year_of_publication = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Year of Publication Is Empty';
                          } else {
                            return null;
                          }
                        },
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Year of Publication',
                          hintStyle: TextStyle(color: Colors.black45),
                          prefixIcon: Icon(
                            Icons.public,
                            color: kBackground2,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      TextFormField(
                        onSaved: (value) {
                          _publisher = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Publisher Is Empty';
                          } else {
                            return null;
                          }
                        },
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Publisher',
                          hintStyle: TextStyle(color: Colors.black45),
                          prefixIcon: Icon(
                            Icons.publish,
                            color: kBackground2,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      TextFormField(
                        onSaved: (value) {
                          _language = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Language Is Empty';
                          } else {
                            return null;
                          }
                        },
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Language',
                          hintStyle: TextStyle(color: Colors.black45),
                          prefixIcon: Icon(
                            Icons.language,
                            color: kBackground2,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      MyButton(
                        name: 'Add Book',
                        onPressed: () async {
                          if (!_formKey.currentState.validate()) {
                            return;
                          } else {
                            _formKey.currentState.save();
                            _store
                                .addBook(Book(
                              bIsbn: _isbn,
                              bImage: _image,
                              bTitle: _title,
                              bDescription: _description,
                              bAuthor: _author,
                              byear_of_publication: _year_of_publication,
                              bPublisher: _publisher,
                              bLanguage: _language,
                              bAuthorImage: _authorImage,
                            ))
                                .then((value) {
                              _scaffoldKey.currentState.showSnackBar(
                                SnackBar(
                                  content: Text("Book added successfully"),
                                ),
                              );
                            });
                          }
                        },
                      ),
                    ],
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
