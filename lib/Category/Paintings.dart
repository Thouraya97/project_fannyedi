import 'dart:io';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_fannyedi/CRUD/MyCart.dart';
import 'package:project_fannyedi/CRUD/MyProduct.dart';
import 'package:project_fannyedi/CRUD/addpage.dart';
import 'package:project_fannyedi/CRUD/informationPage.dart';
import 'package:project_fannyedi/CRUD/updatepage.dart';
import 'package:project_fannyedi/Login_Register/LogInScreen.dart';
import 'package:project_fannyedi/Login_Register/User_Profile.dart';
import 'package:project_fannyedi/firstScreen.dart';
import 'package:project_fannyedi/viewpage.dart'; //formateo hora

File image;
String filename;

class Paintings extends StatefulWidget {
String currentEmail ;
 Paintings(this.currentEmail);
  @override
  _PaintingsState createState() => _PaintingsState(currentEmail);
}

class _PaintingsState extends State<Paintings> {
  String name;
      String uid = FirebaseAuth.instance.currentUser.uid;

  String product;
  String id;
  final db = FirebaseFirestore.instance;


  String currentEmail;

  _PaintingsState(this.currentEmail);
 
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

      case 5:
        return _profile;
        break;
    }
  }

  void deleteData(DocumentSnapshot doc) async {
    await db.collection('Products').doc(doc.id).delete();
    setState(() => id = null);
  }

  //create tha funtion navigateToDetail
  navigateToDetail(DocumentSnapshot ds) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyUpdatePage(
                  ds: ds,
                )));
  }

  //create tha funtion navigateToDetail
  navigateToInfo(DocumentSnapshot ds) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyInfoPage(
                  ds: ds,
                ))            
    );
  }

  void logOut()  {
    FirebaseAuth.instance.signOut().then((value) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => LogInScreen()));
    });
  }
  Future getPosts() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("Products").get();
    // print();
    return qn.docs;
  }

  @override
  Widget build(BuildContext context) {
    getPosts();
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Color(0xffC90327),
        title: Text('Paintings'),
          
        leading: IconButton(
    icon: Icon(Icons.arrow_back, color: Colors.white),
    onPressed: () {
      Navigator.pop(context);
Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyFirst(currentEmail)),
          );
          }
,
  ), 
       
      ),

      body: 
     
 StreamBuilder(
                 stream: FirebaseFirestore.instance
              .collection("Products")
              .where('category', isEqualTo: 'Paintings')
              .get()
              .asStream(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Text('"Loading...');
                  }
                  int length = snapshot.data.docs.length;
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, //two columns
                  mainAxisSpacing: 0.1, //space the card
                  childAspectRatio: 0.800,
                ),
                itemCount: length,
                padding: EdgeInsets.all(2.0),
                itemBuilder: (_, int index) {
                  final DocumentSnapshot doc = snapshot.data.docs[index];
                  return new Container(
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              InkWell(
                                onTap: () => navigateToDetail(doc),
                                child: new Container(
                                  child: Image.network(
                                    '${doc.data()["image"]}' + '?alt=media',
                                  ),
                                  width: 170,
                                  height: 120,
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text(
                                doc.data()["name"],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 19.0,
                                ),
                              ),
                              subtitle: Text(
                                doc.data()["price"],
                                style: TextStyle(
                                    color: Colors.redAccent, fontSize: 12.0),
                              ),
                              onTap: () => navigateToDetail(doc),
                            ),
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                child: new Row(
                                  children: <Widget>[
                                    uid == doc.data()["ownerId"]
                                        ? IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.redAccent,
                                            ),
                                            onPressed: () => deleteData(doc),
                                          )
                                        : Container(),
                                    IconButton(
                                      icon: Icon(
                                        Icons.remove_red_eye,
                                        color: Colors.black,
                                      ),
                                      onPressed: () => navigateToInfo(doc),
                                     ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                        );
                }),
       
       

    
    );
  }
}
