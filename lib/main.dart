import 'package:flutter/material.dart';
import 'package:project_fannyedi/First_Screens/SplashScreen.dart';

void main() {
  debugShowCheckedModeBanner:
  false;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
  false,
  
      title: 'Flutter Demo',
      home: SplashScreen(),
    );
  }
}
