import 'package:book_recommend/adminPages/models/book.dart';
import 'package:book_recommend/adminPages/services/store.dart';
import 'package:book_recommend/constant.dart';
import 'package:book_recommend/models/usermodel.dart';
import 'package:book_recommend/onBoarding/config/size_config.dart';
import 'package:book_recommend/providers/provider.dart';
import 'package:book_recommend/screens/Recommendation.dart';
import 'package:book_recommend/screens/Search.dart';
import 'package:book_recommend/screens/about.dart';
import 'package:book_recommend/screens/chat/chatScreen.dart';
import 'package:book_recommend/screens/contactus.dart';
import 'package:book_recommend/screens/details.dart';
import 'package:book_recommend/screens/favorite.dart';
import 'package:book_recommend/screens/interest.dart';
import 'package:book_recommend/screens/login.dart';
import 'package:book_recommend/screens/profile.dart';
import 'package:book_recommend/screens/saved.dart';
import 'package:book_recommend/setting/Style/models_providers/theme_provider.dart';
import 'package:book_recommend/setting/Style/pages/home_page.dart';
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
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      child: Drawer(
        child: Container(
          color: themeProvider.isLightTheme ? Colors.white : Color(0xFF26242e),
          child: ListView(
            children: [
              _buildUserAccountsDrawerHeader(),
              ListTile(
                onTap: () {
                  Navigator.pushReplacementNamed(context, HomeScreen.id);
                },
                leading: Icon(
                  Icons.home_outlined,
                  color: kBackground2,
                ),
                title: Text(
                  'Home',
                  style: TextStyle(
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
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushReplacementNamed(context, Recommendation.id);
                },
                leading: Icon(
                  Icons.book_outlined,
                  color: kBackground2,
                ),
                title: Text(
                  'Recommend',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushReplacementNamed(context, InterestBook.id);
                },
                leading: Icon(
                  Icons.star_border,
                  color: kBackground2,
                ),
                title: Text(
                  'Interests',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushReplacementNamed(context, Favorite.id);
                },
                leading: Icon(
                  Icons.favorite_outline,
                  color: kBackground2,
                ),
                title: Text(
                  'Favorite',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushReplacementNamed(context, Save.id);
                },
                leading: Icon(
                  Icons.save_outlined,
                  color: kBackground2,
                ),
                title: Text(
                  'Saved',
                  style: TextStyle(
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
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushReplacementNamed(context, HomePage.id);
                },
                leading: Icon(
                  Icons.settings_outlined,
                  color: kBackground2,
                ),
                title: Text(
                  'Settings',
                  style: TextStyle(
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
                    fontWeight: FontWeight.bold,
                  ),
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
                fontSize: 25.0, color: Colors.white, fontFamily: 'pacifico'),
          ),
          currentAccountPicture: CircleAvatar(
            backgroundImage: e.userImage == null
                ? AssetImage('assets/images/userImage.png')
                : NetworkImage(e.userImage),
          ),
          decoration: BoxDecoration(color: kBackground2),
          accountEmail: Text(
            e.userEmail,
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.white,
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
    //Size size = MediaQuery.of(context).size;
    final _store = Store();
    SizeConfig().init(context);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      drawer: _builgDrawer(),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: SizeConfig.defaultSize * 14,
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
                        padding: EdgeInsets.only(
                          top: SizeConfig.defaultSize * 1.2,
                          left: SizeConfig.defaultSize * 1.2,
                          right: SizeConfig.defaultSize * 1.2,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.sort,
                                color: Colors.white,
                                size: SizeConfig.defaultSize * 3.3,
                              ),
                              onPressed: () {
                                _scaffoldKey.currentState.openDrawer();
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.search_outlined,
                                color: Colors.white,
                                size: SizeConfig.defaultSize * 3.3,
                              ),
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, SearchScreen.id);
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.defaultSize * 3,
                          vertical: SizeConfig.defaultSize * 0.5,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 41,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 35,
                                backgroundColor: Colors.white,
                                backgroundImage: AssetImage(
                                  'assets/icons/thisicon.png',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.defaultSize * 1.5,
                            ),
                            Container(
                              child: Text(
                                'Find the best book\nfor you !',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConfig.defaultSize * 1.9,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
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
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: Text(
                          "Discover new book",
                          style: TextStyle(
                            fontSize: SizeConfig.defaultSize * 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.defaultSize * 0.5,
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
                                    bAuthorImage: data[kBookAuthorImage],
                                    bIsbn: data[kBookIsbn],
                                    byear_of_publication:
                                        data[kBookYearOfPublication],
                                    bLanguage: data[kBookLanguage],
                                  ));
                                }
                                return GridView.builder(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 5,
                                  ),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.9,
                                  ),
                                  itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacementNamed(
                                            context, Details.id,
                                            arguments: books[index]);
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                        child: Stack(
                                          children: [
                                            Positioned.fill(
                                              child: books[index].bImage == null
                                                  ? Container()
                                                  : Image(
                                                      fit: BoxFit.fill,
                                                      image: NetworkImage(
                                                          books[index].bImage),
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
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 6,
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
                                                          fontSize: 14,
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
