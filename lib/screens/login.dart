import 'package:book_recommend/adminPages/Dashboard.dart';
import 'package:book_recommend/constant.dart';
import 'package:book_recommend/screens/home.dart';
import 'package:book_recommend/screens/register.dart';
import 'package:book_recommend/screens/reset.dart';
import 'package:book_recommend/widgets/haveaccountornot.dart';
import 'package:book_recommend/widgets/mybutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regExp = new RegExp(p);
bool obscureText = true;
bool isLoading = false;
final TextEditingController email = TextEditingController();
final TextEditingController password = TextEditingController();
String adminPassword = 'admin1234';

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void submit(context) async {
    try {
      setState(() {
        isLoading = true;
      });

      if (password.text == adminPassword) {
        try {
          setState(() {
            isLoading = true;
          });

          UserCredential result = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: email.text, password: password.text);
          print(result);
          Navigator.pushReplacementNamed(context, Dashboard.id);
        } on PlatformException catch (error) {
          var message = "Please Check Your Internet Connection ";
          if (error.message != null) {
            message = error.message;
          }
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text(message.toString()),
              duration: Duration(milliseconds: 800),
              backgroundColor: Theme.of(context).primaryColor,
            ),
          );
          setState(() {
            isLoading = false;
          });
        }
      } else {
        setState(() {
          isLoading = true;
        });
        UserCredential result = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: email.text, password: password.text);
        print(result);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (ctx) => HomeScreen(),
          ),
        );
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(error.toString()),
        duration: Duration(milliseconds: 800),
        backgroundColor: Theme.of(context).primaryColor,
      ));
    }
    setState(() {
      isLoading = false;
    });
  }

  void validation() async {
    if (email.text.isEmpty && password.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Fields Are Empty'),
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
          content: Text('Password Is Too Short'),
        ),
      );
    } else {
      submit(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
              vertical: 30.0,
            ),
            child: Form(
              key: _formKey,
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Image.asset(
                      'assets/icons/backlogo.png',
                      height: size.width * 0.43,
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Text(
                      'SignIn',
                      style: TextStyle(
                        fontFamily: 'pacifico',
                        fontSize: 30.0,
                        color: Theme.of(context).backgroundColor,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Column(
                      children: [
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
                          height: size.height * 0.01,
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
                                setState(() {
                                  obscureText = !obscureText;
                                });
                                FocusScope.of(context).unfocus();
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
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, ResetPassword.id);
                          },
                          child: Text(
                            'Forget Password ?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: kBackground2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    isLoading == false
                        ? MyButton(
                            name: 'Login',
                            onPressed: () {
                              validation();
                            },
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    HaveAcountOrNot(
                      title: 'Don\'t have an account ? ',
                      subTitle: ' Sign Up',
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, RegisterScreen.id);
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
