import 'package:flutter/material.dart';
import 'package:project_fannyedi/Category/Accessory.dart';
import 'package:project_fannyedi/Category/Decorations.dart';
import 'package:project_fannyedi/Category/HandMadeToys.dart';
import 'package:project_fannyedi/Category/Knittings.dart';
import 'package:project_fannyedi/Category/Paintings.dart';

import 'Others.dart';

class HorizontalList extends StatefulWidget {
 String currentEmail;

 HorizontalList(this.currentEmail);
  @override
  _HorizontalListState createState() => _HorizontalListState(currentEmail);
}

class _HorizontalListState extends State<HorizontalList> {
String currentEmail;

  _HorizontalListState(this.currentEmail);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          
         Category(
            image_location: 'assets/jewelry.png',
            image_caption: 'Accessory', onTap: (){
                                    Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                           Accessory(currentEmail)));
            },
            
          ),

        Category(
            image_location: 'assets/decoration.png',
            image_caption: 'Decorations', onTap: (){
                                    Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                           Decorations(currentEmail)));
            },
            
          ), Category(
            image_location: 'assets/dolls.png',
            image_caption: 'HandMade Toys', onTap: (){
                                    Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                           HandMadeToys(currentEmail)));
            },
            
          ),
          Category(
            image_location: 'assets/painting.png',
            image_caption: 'Paintings', onTap: (){
                                    Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                           Paintings(currentEmail)));
            },
            
          ),
          Category(
            image_location: 'assets/knitting.png',
            image_caption: 'Knittings', onTap: (){
                                    Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                           Knittings(currentEmail)));
            },
            
          ),
           Category(
            image_location: 'assets/others.jpg',
            image_caption: 'others', onTap: (){
                                    Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                           Others(currentEmail)));
            },
            
          ), 
          
          
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String image_location;
  final String image_caption;
final Function onTap;
  String currentEmail;
  Category({this.image_location, this.image_caption, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: InkWell(
        onTap:onTap,
        child: Container(
          width: 120.0,
          child: ListTile(
            title: Image.asset(
              image_location,
              width: 50.0,
              height: 33.0,
            ),
            subtitle: Container(
              alignment: Alignment.topCenter,
              child: Text(image_caption, style: new TextStyle(fontSize: 12.0),),
            )
          ),
        ),
      ),
    );
  }
}