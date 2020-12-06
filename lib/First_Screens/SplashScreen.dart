import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/material.dart';
import 'package:project_fannyedi/HomeScreen.dart';
import 'package:project_fannyedi/viewpage.dart';
import 'package:firebase_core/firebase_core.dart';

import 'onBoardingScreen1.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'HomeScreen.dart';
//import 'LogInScreen.dart';
import 'OnBoardingScreens.dart';
import 'package:project_fannyedi/HomeScreen.dart';
//import 'package:project_fannyedi/CRUD/viewpage.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SplashScreen();
  }
}

class _SplashScreen extends State<SplashScreen> {



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xffC90327),
      body: Center(
        child: Image.asset('assets/logos.png'),
      ),
    );
  }

  FirebaseAuth auth = FirebaseAuth.instance;
//first we need to navigate to log in screen
  void NavigateToLogIn() {
    Timer(Duration(seconds: 5), () async {
      if ( auth.currentUser == null) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => Welcome()));
      } else {
        currentEmail();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    //    initializeFlutterFire();
    NavigateToLogIn();
  }

  Future<void> currentEmail() async {
    if (auth.currentUser!=null) {

      Navigator.of(context).pushReplacement(MaterialPageRoute(
          /*builder: (BuildContext context) => HomeScreen(value.email))*/
          builder: (BuildContext context) => MyHomePage(auth.currentUser.email.toString()))
          );
    }
  }
}
