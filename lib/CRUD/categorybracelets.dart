import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_fannyedi/CRUD/MyCart.dart';
import 'package:project_fannyedi/CRUD/addpage.dart';
import 'package:project_fannyedi/CRUD/informationPage.dart';
import 'package:project_fannyedi/CRUD/updatepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_fannyedi/Login_Register/LogInScreen.dart';

//import 'Login_Register/Profile.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:project_fannyedi/Login_Register/User_Profile.dart';
import 'package:project_fannyedi/CRUD/MyProduct.dart';


void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

/*class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'View Page',
      theme: new ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: new MyHomePage(),
    );
  }
}*/

class CommonThings {
  static Size size;
}

class categorybracelets extends StatefulWidget {
  String currentEmail;

 categorybracelets  (this.currentEmail);

  @override
  _categorybraceletsState createState() => _categorybraceletsState(currentEmail);
}

class _categorybraceletsState extends State<categorybracelets > {
  String currentEmail;
  FirebaseAuth auth = FirebaseAuth.instance;

  int _page = 0;
  Future<void> Goto() async {
    if (auth.currentUser != null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          /*builder: (BuildContext context) => HomeScreen(value.email))*/
          builder: (BuildContext context) =>
              categorybracelets(auth.currentUser.email)));
    }
  }

  /// TextEditingController recipeInputController;
  //TextEditingController nameInputController;
  String id;
  final db = FirebaseFirestore.instance;
  final MyAddPage add = MyAddPage();
  Widget _showPage = new MyAddPage();
  Widget _pageChooser(int page) {
    switch (page) {
      case 2:
        return add;
    }
  }

  // final ProfileScreen profile = ProfileScreen();

  //final _formKey = GlobalKey<FormState>();
  String name;
  String product;
  _categorybraceletsState(this.currentEmail);

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
                )));
  }

  void logOut()  {
    FirebaseAuth.instance.signOut().then((value) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => LogInScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffC90327),
        title: Text('Home Page'),
        actions: <Widget>[],
      ),
       
      // image_carousel,
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 170,
              color: Colors.black,
              child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 30)),
                  Image(
                    image: AssetImage("assets/logos.png"),
                    height: 90,
                    width: 90,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    currentEmail,
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
            ListTile(
              title: Text("Upload"),
              leading: Icon(Icons.add_business),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => MyAddPage()));
              },
            ),

            ListTile(
              title: Text("My Products"),
              leading: Icon(Icons.collections_bookmark),
              onTap: () {
                if (auth.currentUser != null) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      /*builder: (BuildContext context) => HomeScreen(value.email))*/
                      builder: (BuildContext context) =>
                          MyProducts(auth.currentUser.email)));
                }

                ///  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => MyProducts()));
              },
            ),
            ListTile(
              title: Text("My Cart"),
              leading: Icon(Icons.local_grocery_store),
              onTap: () {
                if (auth.currentUser != null) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      /*builder: (BuildContext context) => HomeScreen(value.email))*/
                      builder: (BuildContext context) =>
                          MyCart(auth.currentUser.email)));
                }

                ///  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => MyProducts()));
              },
            ),

            ListTile(
                title: Text("My Profile"),
                leading: Icon(Icons.person),
                onTap: () {
                  if (auth.currentUser != null) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => ProfileScreen()));
                  }
                }),
            Divider(),

            ListTile(
                title: Text("My Home"),
                leading: Icon(Icons.home),
                onTap: () {
                  if (auth.currentUser != null) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            categorybracelets(currentEmail)));
                  }
                }),
            Divider(),

            ListTile(
                title: Text("Log Out"),
                leading: Icon(Icons.logout),
                onTap: () {
                  FirebaseAuth.instance.signOut().then((value) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => LogInScreen()));
    });
                }),
            Divider(),

            ListTile(
              title: Text("Contact Us"),
              leading: Icon(Icons.email),
            ) //line

            //line
          ],
        ),
      ),

      body: 
    
 StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Products")
              .where('category', isEqualTo: 'bracelet')
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
