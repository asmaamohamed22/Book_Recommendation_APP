import 'package:book_recommend/constant.dart';
import 'package:flutter/material.dart';

class FaceBook extends StatefulWidget {
  @override
  _FaceBookState createState() => _FaceBookState();
}

class _FaceBookState extends State<FaceBook> {
  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      splashColor: kBackground1,
      onPressed: () async {
        //await signWithGoogle();
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
            Image(
                image: AssetImage("assets/images/Facebook_Logo.png"),
                height: 30.0),
          ],
        ),
      ),
    );
  }
}
