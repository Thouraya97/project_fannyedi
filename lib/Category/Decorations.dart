import 'dart:io';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_fannyedi/CRUD/addpage.dart';
import 'package:project_fannyedi/CRUD/informationPage.dart';
import 'package:project_fannyedi/CRUD/updatepage.dart';
import 'package:project_fannyedi/Login_Register/LogInScreen.dart';
import 'package:project_fannyedi/viewpage.dart'; //formateo hora

File image;
String filename;

class Decorations extends StatefulWidget {
  final DocumentSnapshot ds;
 Decorations({this.ds});
  @override
  _DecorationsState createState() => _DecorationsState();
}

class _DecorationsState extends State<Decorations> {
  String name;
  String product;
  String id;
  final db = FirebaseFirestore.instance;
  final MyAddPage add = MyAddPage();
  Widget _showPage = new MyAddPage();

  String currentEmail ="";
  Widget _pageChooser(int page) {
    switch (page) {
      case 2:
        return add;
    }
  }

  // final ProfileScreen profile = ProfileScreen();

  //final _formKey = GlobalKey<FormState>();
  
 // _categoryautreState();

  //create function for delete one register
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
        title: Text('Decorations'),
          
        leading: IconButton(
    icon: Icon(Icons.arrow_back, color: Colors.white),
    onPressed: () {
      Navigator.pop(context);
Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyHomePage(currentEmail)),
          );
          }
,
  ), 
       
      ),

      body: 
    
 StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Products")
              .where('category', isEqualTo: 'Decorations')
              .get()
              .asStream(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Text('"Loading...');
            }
           // print(bracelet);
            int length = snapshot.data.docs.length;
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, //two columns
                  mainAxisSpacing: 0.1, //space the card
                  childAspectRatio: 0.800, //space largo de cada card
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
                                    IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.redAccent,
                                      ),
                                      onPressed: () =>
                                          deleteData(doc), //funciona
                                    ),
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
                });
          }),

    
      bottomNavigationBar: CurvedNavigationBar(
        color: Color(0xffC90327),
        backgroundColor: Colors.white,
        buttonBackgroundColor: Color(0xffC90327),
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(Icons.favorite, size: 30, color: Colors.white),
          Icon(Icons.add, size: 30, color: Colors.white),
          Icon(Icons.local_grocery_store, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
        ],
        animationCurve: Curves.bounceInOut,
        animationDuration: Duration(milliseconds: 200),
        onTap: (tappedIndex) {
          setState(() {
            // if (index == 2) {
            _showPage = _pageChooser(tappedIndex);
          });
        },
      ),
    );
  }
 
}