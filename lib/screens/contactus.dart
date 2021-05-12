import 'package:book_recommend/feedback/store1.dart';
import 'package:book_recommend/constant.dart';
import 'package:book_recommend/feedback/contact.dart';
import 'package:book_recommend/providers/notification_provider.dart';
import 'package:book_recommend/screens/home.dart';
import 'package:book_recommend/widgets/mybutton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactUs extends StatefulWidget {
  static String id = 'ContactUs';
  @override
  _ContactUsState createState() => _ContactUsState();
}

bool isLoading = false;

class _ContactUsState extends State<ContactUs> {
  String name, email, message;
  Contact contact;
  final _store1 = Store1();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FeedbackProvider feedbackProvider;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    feedbackProvider = Provider.of<FeedbackProvider>(context);
    print(name);
    return WillPopScope(
      onWillPop: () {
        return Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (ctx) => HomeScreen()));
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 27),
                    height: size.height * 0.8,
                    width: double.infinity,
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.06,
                        ),
                        Text(
                          "Send Us Your Message",
                          style: TextStyle(
                            color: kBackground2,
                            fontSize: 28,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.07,
                        ),
                        TextFormField(
                          onSaved: (value) {
                            name = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Name Is Empty';
                            } else {
                              return null;
                            }
                          },
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Name',
                            prefixIcon: Icon(
                              Icons.title,
                              color: kBackground2,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.04,
                        ),
                        TextFormField(
                          onSaved: (value) {
                            email = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Email Is Empty';
                            } else {
                              return null;
                            }
                          },
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Email',
                            prefixIcon: Icon(
                              Icons.email,
                              color: kBackground2,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.04,
                        ),
                        TextFormField(
                          onSaved: (value) {
                            message = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Message Is Empty';
                            } else {
                              return null;
                            }
                          },
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Message',
                            prefixIcon: Icon(
                              Icons.message,
                              color: kBackground2,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.1,
                        ),
                        MyButton(
                          name: "Send",
                          onPressed: () async {
                            if (!_formKey.currentState.validate()) {
                              return;
                            } else {
                              _formKey.currentState.save();
                              _store1
                                  .addFeedback(Contact(
                                fName: name,
                                fEmail: email,
                                fMessage: message,
                              ))
                                  .then((value) {
                                _scaffoldKey.currentState.showSnackBar(
                                  SnackBar(
                                    content: Text("Message added successfully"),
                                  ),
                                );
                              });
                              feedbackProvider.addNotification("Notification");
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
