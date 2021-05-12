import 'package:book_recommend/adminPages/bookDetails.dart';
import 'package:book_recommend/adminPages/models/book.dart';
import 'package:book_recommend/adminPages/services/store.dart';
import 'package:book_recommend/constant.dart';
import 'package:book_recommend/models/usermodel.dart';
import 'package:book_recommend/providers/provider.dart';
import 'package:book_recommend/screens/about.dart';
import 'package:book_recommend/screens/chat/chatScreen.dart';
import 'package:book_recommend/screens/contactus.dart';
import 'package:book_recommend/screens/login.dart';
import 'package:book_recommend/screens/profile.dart';
import 'package:book_recommend/setting/setting.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'HomeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

BookProvider bookProvider;

class _HomeScreenState extends State<HomeScreen> {
  Widget _builgDrawer() {
    return Container(
      child: Drawer(
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: ListView(
            children: [
              _buildUserAccountsDrawerHeader(),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, HomeScreen.id);
                },
                leading: Icon(
                  Icons.home_outlined,
                  color: kBackground2,
                ),
                title: Text(
                  'Home',
                  style: TextStyle(
                    color: Theme.of(context).backgroundColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushReplacementNamed(context, ProfileScreen.id);
                },
                leading: Icon(
                  Icons.person_outlined,
                  color: kBackground2,
                ),
                title: Text(
                  'Profile',
                  style: TextStyle(
                    color: Theme.of(context).backgroundColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushReplacementNamed(context, ChatScreen.id);
                },
                leading: Icon(
                  Icons.group_outlined,
                  color: kBackground2,
                ),
                title: Text(
                  'Room',
                  style: TextStyle(
                    color: Theme.of(context).backgroundColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  //  Navigator.pushReplacementNamed(context, ChatScreen.id);
                },
                leading: Icon(
                  Icons.favorite_outline,
                  color: kBackground2,
                ),
                title: Text(
                  'Favorite',
                  style: TextStyle(
                    color: Theme.of(context).backgroundColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  // Navigator.of(context).pushReplacementNamed('homeApp');
                },
                leading: Icon(
                  Icons.save_outlined,
                  color: kBackground2,
                ),
                title: Text(
                  'Saved',
                  style: TextStyle(
                    color: Theme.of(context).backgroundColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushReplacementNamed(context, ContactUs.id);
                },
                leading: Icon(
                  Icons.mail_outline,
                  color: kBackground2,
                ),
                title: Text(
                  'Contact Us',
                  style: TextStyle(
                    color: Theme.of(context).backgroundColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushReplacementNamed(context, AboutScreen.id);
                },
                leading: Icon(
                  Icons.info_outlined,
                  color: kBackground2,
                ),
                title: Text(
                  'About',
                  style: TextStyle(
                    color: Theme.of(context).backgroundColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushReplacementNamed(context, Setting.id);
                },
                leading: Icon(
                  Icons.settings_outlined,
                  color: kBackground2,
                ),
                title: Text(
                  'Settings',
                  style: TextStyle(
                    color: Theme.of(context).backgroundColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                onTap: () async {
                  await FirebaseAuth.instance.signOut().then((value) {
                    Navigator.pushReplacementNamed(context, LoginScreen.id);
                  });
                },
                leading: Icon(
                  Icons.exit_to_app,
                  color: kBackground2,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(
                    color: Theme.of(context).backgroundColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset(
                      'assets/images/kingicon.png',
                      height: 70,
                      width: 70,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserAccountsDrawerHeader() {
    List<UserModel> userModel = bookProvider.userModelList;
    return Column(
      children: userModel.map((e) {
        return UserAccountsDrawerHeader(
          accountName: Text(
            e.userName,
            style: TextStyle(
              color: Theme.of(context).backgroundColor,
              fontSize: 20.0,
            ),
          ),
          currentAccountPicture: CircleAvatar(
            backgroundImage: e.userImage == null
                ? AssetImage('assets/images/userImage.png')
                : NetworkImage(e.userImage),
            radius: 50.0,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          accountEmail: Text(
            e.userEmail,
            style: TextStyle(
              color: Theme.of(context).backgroundColor,
              fontSize: 15.0,
            ),
          ),
        );
      }).toList(),
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  void getCallAllFunction() {
    bookProvider.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    bookProvider = Provider.of<BookProvider>(context);
    getCallAllFunction();
    Size size = MediaQuery.of(context).size;
    final _store = Store();
    Book book;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      resizeToAvoidBottomPadding: false,
      key: _scaffoldKey,
      drawer: _builgDrawer(),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: size.height * 0.3,
                  child: Stack(
                    children: [
                      Container(
                        height: size.height * 0.3 - 27,
                        decoration: BoxDecoration(
                          color: kBackground2,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(30.0),
                            bottomLeft: Radius.circular(30.0),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                vertical: 20.0,
                                horizontal: 20.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.sort,
                                      color: Colors.white,
                                      size: 35,
                                    ),
                                    onPressed: () {
                                      _scaffoldKey.currentState.openDrawer();
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.search,
                                      color: Colors.white,
                                      size: 35,
                                    ),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 35,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 45,
                                        backgroundColor: Colors.white,
                                        backgroundImage: AssetImage(
                                          'assets/skip/home.png',
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Container(
                                        child: Text(
                                          'What do you want\n to read ?',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        left: 0,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          margin: EdgeInsets.symmetric(horizontal: 25),
                          height: 50,
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 3),
                                  blurRadius: 5,
                                  color: kBackground2.withOpacity(0.5))
                            ],
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintStyle:
                                  TextStyle(color: kBackground2, fontSize: 18),
                              hintText: 'Search',
                              suffixIcon: Icon(
                                Icons.search,
                                color: kBackground2,
                                size: 30,
                              ),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: Text(
                          "Recommended",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).backgroundColor),
                        ),
                      ),
                      Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                            stream: _store.loadBook(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<Book> books = [];
                                for (var doc in snapshot.data.docs) {
                                  var data = doc.data();
                                  books.add(Book(
                                    bId: doc.id,
                                    bImage: data[kBookImage],
                                    bTitle: data[kBookTitle],
                                    bDescription: data[kBookDescription],
                                    bPublisher: data[kBookPublisher],
                                    bAuthor: data[kBookAuthor],
                                    bCategory: data[kBookCategory],
                                    bIsbn: data[kBookIsbn],
                                    byear_of_publication:
                                        data[kBookYearOfPublication],
                                    bLanguage: data[kBookLanguage],
                                  ));
                                }
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 6),
                                  child: GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.85,
                                    ),
                                    itemBuilder: (context, index) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: GestureDetector(
                                        onTap: () {
                                         // Navigator.pushNamed(
                                             // context, BookDetails.id,
                                             // arguments: books[index]);
                                        },
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)),
                                          child: Stack(
                                            children: [
                                              Positioned.fill(
                                                child:
                                                    books[index].bImage == null
                                                        ? Container()
                                                        : Image(
                                                            fit: BoxFit.fill,
                                                            image: NetworkImage(
                                                                books[index]
                                                                    .bImage),
                                                          ),
                                              ),
                                              Positioned(
                                                bottom: 0,
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 60,
                                                  color: Colors.black87,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 4),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          books[index].bTitle,
                                                          style: TextStyle(
                                                            color: kBackground2,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                        SizedBox(height: 3),
                                                        Text(
                                                          books[index].bAuthor,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    itemCount: books.length,
                                  ),
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
