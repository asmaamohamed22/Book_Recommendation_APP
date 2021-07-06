import 'package:book_recommend/feedback/store1.dart';
import 'package:book_recommend/constant.dart';
import 'package:book_recommend/feedback/contact.dart';
import 'package:book_recommend/onBoarding/config/size_config.dart';
import 'package:book_recommend/providers/notification_provider.dart';
import 'package:book_recommend/screens/home.dart';
import 'package:book_recommend/setting/Style/models_providers/theme_provider.dart';
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
    SizeConfig().init(context);
    feedbackProvider = Provider.of<FeedbackProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    print(name);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor:
            themeProvider.isLightTheme ? Colors.white : Color(0xFF26242e),
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.defaultSize * 2.5,
                  ),
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
                          fontSize: SizeConfig.defaultSize * 2.5,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.defaultSize * 3,
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
                        height: SizeConfig.defaultSize * 2,
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
                        height: SizeConfig.defaultSize * 2,
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
                      Padding(
                        padding: EdgeInsets.only(
                          top: SizeConfig.defaultSize * 3,
                          bottom: SizeConfig.defaultSize * 2,
                        ),
                        child: MyButton(
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
                                    content: Text("Message Send successfully"),
                                  ),
                                );
                              });
                              feedbackProvider.addNotification("Notification");
                              feedbackProvider.addCount();
                            }
                          },
                        ),
                      )
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
