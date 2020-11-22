import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'onBoardingScreen1.dart';
import 'onBoardingScreen2.dart';
import 'onBoardingScreen3.dart';


class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  int currentPageIndex;
  int pageLength;

  @override
  void initState() {
    currentPageIndex = 0;
    pageLength = 3;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: <Widget>[
              PageView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  onBoarding1(),
                  onBoarding2(),
                  onBoarding3()
                  
                ],
                onPageChanged: (value) {
                  setState(() {
                    currentPageIndex = value;
                  });
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new DotsIndicator(
                      dotsCount: pageLength,
                      position: currentPageIndex.toDouble(),
                    )
                  ],
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}