import 'package:book_recommend/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  String _enteredMessage = "";

  _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    final userData =
        await FirebaseFirestore.instance.collection('User').doc(user.uid).get();
    FirebaseFirestore.instance.collection('Chat').add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'username': userData['UserName'],
      'userimage': userData['UserImage'],
      'userId': user.uid,
    });
    _controller.clear();
    setState(() {
      _enteredMessage = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 80,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 60,
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.grey[500],
                ),
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.emoji_emotions_outlined,
                    color: Colors.grey[500],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      autocorrect: true,
                      enableSuggestions: true,
                      decoration: InputDecoration(
                        hintText: "Type your message .....",
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Colors.grey[500],
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _enteredMessage = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          CircleAvatar(
            radius: 20,
            backgroundColor: kBackground2,
            child: IconButton(
              icon: Icon(
                Icons.send,
                color: Colors.white,
                size: 25,
              ),
              onPressed: () =>
                  _enteredMessage.trim().isEmpty ? null : _sendMessage(),
            ),
          ),
        ],
      ),
    );
  }
}
