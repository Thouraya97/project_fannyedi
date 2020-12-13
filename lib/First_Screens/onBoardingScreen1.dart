import 'dart:async';

//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'HomeScreen.dart';
//import 'LogInScreen.dart';

class onBoarding1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _onBoarding1();
  }
}

class _onBoarding1 extends State<onBoarding1> {
  
@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffC90327),
      body: Container(
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/Onboarding1.png"),
        fit: BoxFit.cover
        ),
         )
              ),
      
    
    );
  }
}
