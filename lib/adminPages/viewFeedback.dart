import 'package:book_recommend/feedback/store1.dart';
import 'package:book_recommend/constant.dart';
import 'package:book_recommend/feedback/contact.dart';
import 'package:book_recommend/providers/notification_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:book_recommend/adminPages/Dashboard.dart';

class ViewFeedback extends StatefulWidget {
  static String id = 'ViewFeedback';
  @override
  _ViewFeedbackState createState() => _ViewFeedbackState();
}

class _ViewFeedbackState extends State<ViewFeedback> {
  final _store1 = Store1();
  Contact contact;
  FeedbackProvider feedbackProvider;
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, Dashboard.id);
          },
          icon: Icon(
            Icons.arrow_back,
            color: kBackground2,
            size: 35,
          ),
        ),
        centerTitle: true,
        title: Text(
          'View Feedback',
          style: TextStyle(
            color: kBackground2,
            fontSize: 25,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _store1.loadFeedback(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Contact> contacts = [];
              for (var doc in snapshot.data.docs) {
                var data = doc.data();
                contacts.add(Contact(
                  fId: doc.id,
                  fName: data[kFeedbackName],
                  fEmail: data[kFeedbackEmail],
                  fMessage: data[kFeedbackMessage],
                ));
              }
              return ListView.builder(
                itemBuilder: (context, index) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: kBackground2,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Name :',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            contacts[index].fName,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Email :',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            contacts[index].fEmail,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      _store1
                                          .deleteMessage(contacts[index].fId)
                                          .then((value) {
                                        _scaffoldKey.currentState.showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                "Message deleted successfully"),
                                          ),
                                        );
                                      });
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                contacts[index].fMessage,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                itemCount: contacts.length,
              );
            } else {
              return Center(
                child: Text('No Messages At Yet'),
              );
            }
          }),
    );
  }
}
