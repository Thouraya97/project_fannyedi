import 'dart:async';
import 'package:flutter/material.dart';

class onBoarding2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _onBoarding2();
  }
}

class _onBoarding2 extends State<onBoarding2> {
  
@override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Color(0xffC90327),
      body: Container(
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/Onboarding2.png"),
        fit: BoxFit.cover
        ),
         )
              ),
    
    );
  }
}
