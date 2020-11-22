import 'dart:async';

//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'HomeScreen.dart';
//import 'LogInScreen.dart';

class onBoarding2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _onBoarding2();
  }
}

class _onBoarding2 extends State<onBoarding2> {
  
@override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      
      backgroundColor: Color(0xffC90327),
      body: Container(
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/Onboarding2.png"),
        fit: BoxFit.cover
        ),
         )
              ),
        //floatingActionButton: ,
    
    );
  }
}
