import 'dart:async';

//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'HomeScreen.dart';
//import 'LogInScreen.dart';
import 'package:project_fannyedi/Login_Register/LogInScreen.dart';

class onBoarding3 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _onBoarding3();
  }
}

class _onBoarding3 extends State<onBoarding3> {
  
@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffC90327),
      body: Container(
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/Onboarding3.png"),
        fit: BoxFit.cover
        ),
         )
              ),
            
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.navigate_next,color: Colors.white,),
          backgroundColor: Colors.black,
          onPressed: (){
             Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (BuildContext context) => LogInScreen()));
     
          },
        ),
    
    );
  }
}
