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
      margin: EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              autocorrect: true,
              enableSuggestions: true,
              decoration: kTextFieldDecoration.copyWith(
                  hintText: "Send a message",
                  border: const OutlineInputBorder()),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.send,
              size: 30,
            ),
            onPressed: () =>
                _enteredMessage.trim().isEmpty ? null : _sendMessage(),
          ),
        ],
      ),
    );
  }
}
