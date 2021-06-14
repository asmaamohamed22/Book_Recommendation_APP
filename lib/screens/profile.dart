import 'package:book_recommend/constant.dart';
import 'package:book_recommend/models/usermodel.dart';
import 'package:book_recommend/providers/provider.dart';
import 'package:book_recommend/screens/home.dart';
import 'package:book_recommend/setting/Style/models_providers/theme_provider.dart';
import 'package:book_recommend/widgets/edit_password.dart';
import 'package:book_recommend/widgets/mybutton.dart';
import 'package:book_recommend/widgets/mytext.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static String id = 'ProfileScreen';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel userModel;
  BookProvider bookProvider;
  TextEditingController phoneNumber;
  TextEditingController userName;
  TextEditingController userEmail;
  TextEditingController userPassword;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(p);
  bool obscureText = true;
  bool isLoading = false;
  bool isEdit = false;

  void validation() async {
    if (userName.text.isEmpty &&
        userEmail.text.isEmpty &&
        userPassword.text.isEmpty &&
        phoneNumber.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Fields Are Empty'),
        ),
      );
    } else if (userName.text.length < 6) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Name Must Be 6'),
        ),
      );
    } else if (userPassword.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Password Is Empty'),
        ),
      );
    } else if (userEmail.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Email Is Empty"),
        ),
      );
    } else if (!regExp.hasMatch(userEmail.text)) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Please Try Valid Email'),
        ),
      );
    } else if (phoneNumber.text.length < 11 || phoneNumber.text.length > 11) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('PhoneNumber Must Be 11'),
        ),
      );
    } else {
      userDetailUpdate();
    }
  }

  File _pickedImage;

  PickedFile _image;
  Future<void> getImage({ImageSource source}) async {
    _image = await ImagePicker().getImage(source: source);
    if (_image != null) {
      setState(() {
        _pickedImage = File(_image.path);
      });
    }
  }

  String userUid;

  Future<String> _uploadImage({File image}) async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child("UserImage/$userUid");
    StorageUploadTask uploadTask = storageReference.putFile(image);
    StorageTaskSnapshot snapshot = await uploadTask.onComplete;
    String imageUrl = await snapshot.ref.getDownloadURL();
    return imageUrl;
  }

  void getUserUid() {
    User myUser = FirebaseAuth.instance.currentUser;
    userUid = myUser.uid;
  }

  bool centerCircle = false;
  var imageMap;
  void userDetailUpdate() async {
    setState(() {
      centerCircle = true;
    });
    _pickedImage != null
        ? imageMap = await _uploadImage(image: _pickedImage)
        : Container();
    FirebaseFirestore.instance.collection("User").doc(userUid).update({
      "UserName": userName.text,
      "UserEmail": userEmail.text,
      "UserNumber": phoneNumber.text,
      "UserPassword": userPassword.text,
      "UserImage": imageMap,
    });
    setState(() {
      centerCircle = false;
    });
    setState(() {
      edit = false;
    });
  }

  Widget _buildSingleContainer({String startText, String endText}) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Card(
      shape: RoundedRectangleBorder(side: BorderSide(color: kBackground1)),
      elevation: 2,
      child: ClipPath(
        child: Container(
          decoration: BoxDecoration(
              color:
                  themeProvider.isLightTheme ? Colors.white : Color(0xFF26242e),
              border: Border(
                right: BorderSide(color: kBackground2, width: 5),
              )),
          child: Container(
            height: 55,
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: edit == false
                  ? BorderRadius.circular(30)
                  : BorderRadius.circular(0),
            ),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  startText,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                Text(
                  endText,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        clipper: ShapeBorderClipper(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(3))),
      ),
    );
  }

  String userImage;
  bool edit = false;
  Widget _buildContainerPart() {
    userName = TextEditingController(text: userModel.userName);
    userEmail = TextEditingController(text: userModel.userEmail);
    phoneNumber = TextEditingController(text: userModel.userPhoneNumber);
    userPassword = TextEditingController(text: userModel.userPassword);

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildSingleContainer(
            endText: userModel.userName,
            startText: "Name",
          ),
          _buildSingleContainer(
            endText: userModel.userEmail,
            startText: "Email",
          ),
          _buildSingleContainer(
            endText: userModel.userPhoneNumber,
            startText: "Phone Number",
          ),
        ],
      ),
    );
  }

  Future<void> myDialogBox(context) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  ListTile(
                    leading: Icon(Icons.camera_alt),
                    title: Text("Pick Form Camera"),
                    onTap: () {
                      getImage(source: ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text("Pick Form Gallery"),
                    onTap: () {
                      getImage(source: ImageSource.gallery);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _buildTextFormFieldPart() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Username',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: kBackground2),
                ),
              ),
              SizedBox(
                height: 6.0,
              ),
              MyText(
                name: "UserName",
                controller: userName,
              ),
            ],
          ),
          Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Phone Number',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: kBackground2),
                ),
              ),
              SizedBox(
                height: 6.0,
              ),
              MyText(
                name: "Phone Number",
                controller: phoneNumber,
              ),
            ],
          ),
          Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Password',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: kBackground2),
                ),
              ),
              SizedBox(
                height: 6.0,
              ),
              EditPassword(
                name: "UserPassword",
                controller: userPassword,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    getUserUid();
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor:
            themeProvider.isLightTheme ? Colors.white : Color(0xFF26242e),
        elevation: 0.0,
        centerTitle: true,
        title: edit == false
            ? Text(
                'View Profile',
                style: TextStyle(
                    color: kBackground2,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )
            : Text(
                'Update Profile',
                style: TextStyle(
                    color: kBackground2,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
        leading: edit == true
            ? IconButton(
                icon: Icon(
                  Icons.close,
                  color: kBackground2,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    edit = false;
                  });
                },
              )
            : IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: kBackground2,
                  size: 35,
                ),
                onPressed: () {
                  setState(() {
                    Navigator.pushReplacementNamed(context, HomeScreen.id);
                  });
                },
              ),
        actions: [
          edit == false
              ? Container()
              : IconButton(
                  icon: Icon(
                    Icons.check,
                    size: 30,
                    color: kBackground2,
                  ),
                  onPressed: () {
                    validation();
                  },
                ),
        ],
      ),
      body: centerCircle == false
          ? ListView(
              children: [
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("User")
                        .snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      var myDoc = snapshot.data.docs;
                      myDoc.forEach((checkDocs) {
                        if (checkDocs.data()["UserId"] == userUid) {
                          userModel = UserModel(
                            userEmail: checkDocs.data()["UserEmail"],
                            userImage: checkDocs.data()["UserImage"],
                            userPassword: checkDocs.data()["UserPassword"],
                            userName: checkDocs.data()["UserName"],
                            userPhoneNumber: checkDocs.data()["UserNumber"],
                          );
                        }
                      });
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        maxRadius: 70,
                                        backgroundColor: kBackground2,
                                        child: CircleAvatar(
                                            maxRadius: 65,
                                            backgroundImage: _pickedImage ==
                                                    null
                                                ? userModel.userImage == null
                                                    ? AssetImage(
                                                        "assets/images/userImage.png")
                                                    : NetworkImage(
                                                        userModel.userImage)
                                                : FileImage(_pickedImage)),
                                      ),
                                    ],
                                  ),
                                ),
                                edit == true
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .viewPadding
                                                    .left +
                                                200,
                                            top: MediaQuery.of(context)
                                                    .viewPadding
                                                    .left +
                                                80),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              myDialogBox(context);
                                            },
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  Colors.transparent,
                                              child: Icon(
                                                Icons.camera_alt,
                                                color: kBackground2,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                            Container(
                              height: 300,
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: edit == true
                                          ? _buildTextFormFieldPart()
                                          : _buildContainerPart(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                child: edit == false
                                    ? MyButton(
                                        name: "Edit Profile",
                                        onPressed: () {
                                          setState(() {
                                            edit = true;
                                          });
                                        },
                                      )
                                    : Container(),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
