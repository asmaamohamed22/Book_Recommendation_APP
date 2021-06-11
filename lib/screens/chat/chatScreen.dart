import 'package:book_recommend/constant.dart';
import 'package:book_recommend/screens/chat/message.dart';
import 'package:book_recommend/screens/chat/new_message.dart';
import 'package:book_recommend/screens/home.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static String id = 'ChatScreen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Room',
          style: TextStyle(
            color: kBackground2,
            fontSize: 30,
            //fontWeight: FontWeight.bold,
            fontFamily: 'pacifico',
          ),
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
      body: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            child: Opacity(
              opacity: 0.2,
              child: Image.asset(
                'assets/icons/backlogo.png',
                height: size.width * 0.6,
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: Messages(),
              ),
              NewMessage(),
            ],
          ),
        ],
      ),
    );
  }
}
