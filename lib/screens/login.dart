import 'package:book_recommend/adminPages/Dashboard.dart';
import 'package:book_recommend/constant.dart';
import 'package:book_recommend/onBoarding/config/size_config.dart';
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
                      'assets/icons/thisicon.png',
                      height: SizeConfig.defaultSize * 13,
                    ),
                    SizedBox(
                      height: SizeConfig.defaultSize * 1,
                    ),
                    Text(
                      'SignIn',
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
                          height: SizeConfig.defaultSize * 1,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, ResetPassword.id);
                          },
                          child: Text(
                            'Forget Password ?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.defaultSize * 1.7,
                              color: kBackground2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.defaultSize * 0.7,
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
                      height: SizeConfig.defaultSize * 0.9,
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
