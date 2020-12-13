import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_fannyedi/CRUD/MyCart.dart';
import 'package:project_fannyedi/CRUD/addpage.dart';
import 'package:project_fannyedi/CRUD/informationPage.dart';
import 'package:project_fannyedi/CRUD/updatepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Login_Register/LogInScreen.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'viewpage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:project_fannyedi/Login_Register/User_Profile.dart';
import 'package:project_fannyedi/CRUD/MyProduct.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class CommonThings {
  static Size size;
}

class MyFirst extends StatefulWidget {
  String currentEmail;

  MyFirst(this.currentEmail);

  @override
  _MyFirstState createState() => _MyFirstState(currentEmail);
}

class _MyFirstState extends State<MyFirst> {
  String currentEmail;
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = FirebaseAuth.instance.currentUser.uid;

  int _page = 0;
  Future<void> Goto() async {
    if (auth.currentUser != null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) =>
              MyHomePage(auth.currentUser.email)));
    }
  }

  int pageIndex = 0;
  String id;
  final db = FirebaseFirestore.instance;
  final MyAddPage _add = new MyAddPage();
  final MyProducts _myproducts =
      new MyProducts(FirebaseAuth.instance.currentUser.email);
  final ProfileScreen _profile = new ProfileScreen();
  final MyCart _chariot = new MyCart(FirebaseAuth.instance.currentUser.email);
  final MyHomePage _home =
      new MyHomePage(FirebaseAuth.instance.currentUser.email);
  //final
  Widget _showPage = new MyHomePage(FirebaseAuth.instance.currentUser.email);
  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        return _home;
        break;

      case 1:
        return _myproducts;
        break;

      case 2:
        return _add;
        break;

      case 3:
        return _chariot;
        break;

      case 4:
        return _profile;
        break;

      
    }
  }

  String name;
  String product;
  _MyFirstState(this.currentEmail);

  void deleteData(DocumentSnapshot doc) async {
    await db.collection('Products').doc(doc.id).delete();
    setState(() => id = null);
  }

  navigateToDetail(DocumentSnapshot ds) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyUpdatePage(
                  ds: ds,
                )));
  }

  navigateToInfo(DocumentSnapshot ds) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyInfoPage(
                  ds: ds,
                )));
  }

  void logOut() {
    FirebaseAuth.instance.signOut().then((value) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => LogInScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // image_carousel,

      body: _showPage,

      bottomNavigationBar: CurvedNavigationBar(
        index: pageIndex,
        color: Color(0xffC90327),
        backgroundColor: Colors.white,
        buttonBackgroundColor: Color(0xffC90327),
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(Icons.collections_bookmark, size: 30, color: Colors.white),
          Icon(Icons.add_business, size: 30, color: Colors.white),
          Icon(Icons.local_grocery_store, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
        ],
        animationCurve: Curves.bounceInOut,
        animationDuration: Duration(milliseconds: 200),
        onTap: (tappedIndex) {
          setState(() {
            _showPage = _pageChooser(tappedIndex);
          });
        },
      ),
    );
  }
}
