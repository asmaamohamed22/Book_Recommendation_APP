import 'package:book_recommend/constant.dart';
import 'package:book_recommend/models/usermodel.dart';
import 'package:book_recommend/providers/provider.dart';
import 'package:book_recommend/screens/home.dart';
import 'package:book_recommend/widgets/mybutton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactUs extends StatefulWidget {
  static String id = 'ContactUs';
  @override
  _ContactUsState createState() => _ContactUsState();
}

bool isLoading = false;

class _ContactUsState extends State<ContactUs> {
  final TextEditingController message = TextEditingController();
  String name, email;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  void validation() async {
    if (message.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Message Is Empty"),
          backgroundColor: kBackground2,
        ),
      );
    } else {
      User user = FirebaseAuth.instance.currentUser;
      FirebaseFirestore.instance.collection("Message").doc(user.uid).set({
        "Name": name,
        "Email": email,
        "Message": message.text,
      }).then((value) => _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text("Message send successfully"),
            ),
          ));
    }
  }

  Widget _buildSingleFlied({String name}) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey),
      ),
      padding: EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    BookProvider provider;
    provider = Provider.of<BookProvider>(context, listen: false);
    List<UserModel> user = provider.userModelList;
    user.map((e) {
      name = e.userName;
      email = e.userEmail;

      return Container();
    }).toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(name);
    return WillPopScope(
      onWillPop: () {
        return Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (ctx) => HomeScreen()));
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, HomeScreen.id);
            },
            icon: Icon(
              Icons.arrow_back,
              color: kBackground2,
              size: 35,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 27),
                  height: size.height * 0.7,
                  width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Text(
                        "Send Us Your Message",
                        style: TextStyle(
                          color: kBackground2,
                          fontSize: 28,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      _buildSingleFlied(name: name),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      _buildSingleFlied(name: email),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Container(
                        height: size.height * 0.3,
                        child: TextFormField(
                          controller: message,
                          expands: true,
                          maxLines: null,
                          textAlignVertical: TextAlignVertical.top,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: " Message",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      MyButton(
                        name: "Send",
                        onPressed: () {
                          validation();
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
