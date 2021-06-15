import 'package:book_recommend/adminPages/models/book.dart';
import 'package:book_recommend/adminPages/services/store.dart';
import 'package:book_recommend/adminPages/viewBook.dart';
import 'package:book_recommend/constant.dart';
import 'package:book_recommend/widgets/mybutton.dart';
import 'package:flutter/material.dart';

class EditBook extends StatefulWidget {
  static String id = 'EditBook';
  @override
  _EditBookState createState() => _EditBookState();
}

class _EditBookState extends State<EditBook> {
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

    Book book = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, ViewBook.id);
          },
          icon: Icon(
            Icons.arrow_back,
            color: kBackground2,
            size: 35,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Edit Book',
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
                            backgroundImage: AssetImage(
                              'assets/icons/bookicon.png',
                            ),
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
                        initialValue: book.bImage ?? "",
                        style: TextStyle(color: Colors.black45),
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Image',
                          // hintStyle: TextStyle(color: Colors.black45),
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
                        initialValue: book.bIsbn ?? "",
                        style: TextStyle(color: Colors.black45),
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'ISBN',
                          // hintStyle: TextStyle(color: Colors.black45),
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
                        initialValue: book.bTitle ?? "",
                        style: TextStyle(color: Colors.black45),
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Title',
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
                        initialValue: book.bDescription ?? "",
                        style: TextStyle(color: Colors.black45),
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Description',
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
                        initialValue: book.bAuthor ?? "",
                        style: TextStyle(color: Colors.black45),
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Author',
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
                            return 'Author Image Is Empty';
                          } else {
                            return null;
                          }
                        },
                        initialValue: book.bAuthorImage ?? "",
                        style: TextStyle(color: Colors.black45),
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Author Image',
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
                        initialValue: book.byear_of_publication ?? "",
                        style: TextStyle(color: Colors.black45),
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Year of Publication',
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
                        initialValue: book.bPublisher ?? "",
                        style: TextStyle(color: Colors.black45),
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Publisher',
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
                        initialValue: book.bLanguage ?? "",
                        style: TextStyle(color: Colors.black45),
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Language',
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
                        name: 'Edit Book',
                        onPressed: () async {
                          if (!_formKey.currentState.validate()) {
                            return;
                          } else {
                            _formKey.currentState.save();
                            _store
                                .editBook(
                                    ({
                                      kBookIsbn: _isbn,
                                      kBookImage: _image,
                                      kBookTitle: _title,
                                      kBookDescription: _description,
                                      kBookAuthor: _author,
                                      kBookYearOfPublication:
                                          _year_of_publication,
                                      kBookPublisher: _publisher,
                                      kBookLanguage: _language,
                                      kBookAuthorImage: _authorImage,
                                    }),
                                    book.bId)
                                .then((value) {
                              _scaffoldKey.currentState.showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.black45,
                                  content: Text("Book edited successfully"),
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
