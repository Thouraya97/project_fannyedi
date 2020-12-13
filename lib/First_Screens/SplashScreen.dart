import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_fannyedi/viewpage.dart';
import 'package:flutter/material.dart';
import '../firstScreen.dart';
import 'OnBoardingScreens.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreen();
  }
}

class _SplashScreen extends State<SplashScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffC90327),
      body: Center(
        child: Image.asset('assets/logos.png'),
      ),
    );
  }

  FirebaseAuth auth = FirebaseAuth.instance;
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
    NavigateToLogIn();
  }

  Future<void> currentEmail() async {
    if (auth.currentUser!=null) {

      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => MyFirst(auth.currentUser.email.toString()))
          );
    }
  }
}
