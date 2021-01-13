import 'package:book_recommend/constant.dart';
import 'package:book_recommend/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSign extends StatefulWidget {
  @override
  _GoogleSignState createState() => _GoogleSignState();
}

class _GoogleSignState extends State<GoogleSign> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      splashColor: kBackground1,
      onPressed: () async {
        await signWithGoogle()
            .whenComplete(() => Navigator.pushNamed(context, HomeScreen.id));
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      highlightElevation: 0,
      borderSide: BorderSide(color: kBackground1),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/images/google.png"), height: 30.0),
          ],
        ),
      ),
    );
  }

  Future<void> signWithGoogle() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    UserCredential userCredential =
        await _auth.signInWithCredential(authCredential);
    User user = userCredential.user;
    print('user email= ${user.email}');
  }
}
