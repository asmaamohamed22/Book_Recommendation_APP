import 'package:book_recommend/constant.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(this.mesage, this.userName, this.userImage, this.isMe,
      {this.key});
  final Key key;
  final String mesage;
  final String userName;
  final String userImage;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment:
                  isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                Container(
                  // width: 150,
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.5),
                  decoration: BoxDecoration(
                    color: isMe ? kBackground2 : kBackground1,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft:
                          !isMe ? Radius.circular(0) : Radius.circular(15),
                      bottomRight:
                          isMe ? Radius.circular(0) : Radius.circular(15),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                  margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Column(
                    crossAxisAlignment: isMe
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: !isMe ? Colors.white : Colors.white,
                            fontSize: 14),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        mesage,
                        style: TextStyle(
                            color: !isMe ? Colors.white : Colors.white,
                            fontSize: 15),
                        textAlign: !isMe ? TextAlign.end : TextAlign.start,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: -5,
            left: !isMe ? MediaQuery.of(context).viewPadding.left : null,
            right: isMe ? MediaQuery.of(context).viewPadding.left : null,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CircleAvatar(
                radius: 13,
                backgroundImage: userImage == ""
                    ? AssetImage('assets/images/userImage.png')
                    : NetworkImage(userImage),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
