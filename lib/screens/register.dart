import 'package:book_recommend/constant.dart';
import 'package:book_recommend/onBoarding/config/size_config.dart';
import 'package:book_recommend/screens/home.dart';
import 'package:book_recommend/screens/login.dart';
import 'package:book_recommend/widgets/haveaccountornot.dart';
import 'package:book_recommend/widgets/mybutton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterScreen extends StatefulWidget {
  static String id = 'RegisterScreen';
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regExp = new RegExp(p);
bool obscureText = true;
bool isLoading = false;
final TextEditingController email = TextEditingController();
final TextEditingController password = TextEditingController();
final TextEditingController userName = TextEditingController();
final TextEditingController phoneNumber = TextEditingController();

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void submit(context) async {
    UserCredential result;
    try {
      setState(() {
        isLoading = true;
      });
      result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text, password: password.text);
      print(result);
    } on PlatformException catch (error) {
      var message = "Please Check Your Internet Connection ";
      if (error.message != null) {
        message = error.message;
      }
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(message.toString()),
        duration: Duration(milliseconds: 600),
      ));
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(error.toString()),
        duration: Duration(milliseconds: 600),
      ));

      print(error);
    }
    FirebaseFirestore.instance.collection("User").doc(result.user.uid).set({
      "UserName": userName.text,
      "UserId": result.user.uid,
      "UserEmail": email.text,
      "UserNumber": phoneNumber.text,
      "UserPassword": password.text,
    });
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (ctx) => HomeScreen()));
    setState(() {
      isLoading = false;
    });
  }

  void validation() async {
    if (userName.text.isEmpty &&
        email.text.isEmpty &&
        password.text.isEmpty &&
        phoneNumber.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('All fields Are Empty'),
        ),
      );
    } else if (userName.text.length < 6) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Name Must Be 6'),
        ),
      );
    } else if (email.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Email Is Empty"),
        ),
      );
    } else if (!regExp.hasMatch(email.text)) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Please Try Valid Email'),
        ),
      );
    } else if (password.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Password Is Empty'),
        ),
      );
    } else if (password.text.length < 8) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Password is too short'),
        ),
      );
    } else if (phoneNumber.text.length < 11 || phoneNumber.text.length > 11) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('PhoneNumber Must Be 11'),
        ),
      );
    } else {
      submit(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.defaultSize * 2.5,
              vertical: SizeConfig.defaultSize * 1.8,
            ),
            child: Form(
              key: _formKey,
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/iconbook.png',
                      height: SizeConfig.defaultSize * 13,
                    ),
                    SizedBox(
                      height: SizeConfig.defaultSize * 1,
                    ),
                    Text(
                      'SignUp',
                      style: TextStyle(
                        fontFamily: 'pacifico',
                        fontSize: SizeConfig.defaultSize * 2.5,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.defaultSize * 1.8,
                    ),
                    Column(
                      children: [
                        TextFormField(
                          controller: userName,
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Username',
                            prefixIcon: Icon(
                              Icons.person,
                              color: kBackground2,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.defaultSize * 1,
                        ),
                        TextFormField(
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Email',
                            prefixIcon: Icon(
                              Icons.email,
                              color: kBackground2,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.defaultSize * 1,
                        ),
                        TextFormField(
                          controller: phoneNumber,
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Phone Number',
                            prefixIcon: Icon(
                              Icons.phone,
                              color: kBackground2,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.defaultSize * 1,
                        ),
                        TextFormField(
                          controller: password,
                          obscureText: obscureText,
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Password',
                            prefixIcon: Icon(
                              Icons.lock,
                              color: kBackground2,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                              child: Icon(
                                obscureText == true
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: kBackground2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.defaultSize * 2,
                    ),
                    isLoading == false
                        ? MyButton(
                            name: 'Register',
                            onPressed: () {
                              validation();
                            },
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          ),
                    SizedBox(
                      height: SizeConfig.defaultSize * 0.9,
                    ),
                    HaveAcountOrNot(
                      title: 'I have an account ! ',
                      subTitle: ' Sign In',
                      onTap: () {
                        Navigator.pushReplacementNamed(context, LoginScreen.id);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
