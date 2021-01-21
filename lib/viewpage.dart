import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_fannyedi/CRUD/MyCart.dart';
import 'package:project_fannyedi/CRUD/addpage.dart';
import 'package:project_fannyedi/CRUD/informationPage.dart';
import 'package:project_fannyedi/CRUD/updatepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_fannyedi/Category/category.dart';
import 'package:project_fannyedi/DataSearch.dart';
import 'Login_Register/LogInScreen.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:project_fannyedi/Login_Register/User_Profile.dart';
import 'package:project_fannyedi/CRUD/MyProduct.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class CommonThings {
  static Size size;
}

class MyHomePage extends StatefulWidget {
  String currentEmail;

  MyHomePage(this.currentEmail);

  @override
  _MyHomePageState createState() => _MyHomePageState(currentEmail);
}

class _MyHomePageState extends State<MyHomePage> {
  String currentEmail;
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = FirebaseAuth.instance.currentUser.uid;
    bool searchState = false;

  int _page = 0;
  Future<void> Goto() async {
    if (auth.currentUser != null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) =>
              MyHomePage(auth.currentUser.email)));
    }
  }

  int pageIndex = 0;
  String id;
  final db = FirebaseFirestore.instance;
  final MyAddPage _add = new MyAddPage();
  final MyProducts _myproducts =
      new MyProducts(FirebaseAuth.instance.currentUser.email);
  final ProfileScreen _profile = new ProfileScreen();
  final MyCart _chariot = new MyCart(FirebaseAuth.instance.currentUser.email);
  final MyHomePage _home =
      new MyHomePage(FirebaseAuth.instance.currentUser.email);
  //final
  
  String name;
  String product;
  _MyHomePageState(this.currentEmail);

  void deleteData(DocumentSnapshot doc) async {
    await db.collection('Products').doc(doc.id).delete();
    setState(() => id = null);
  }

  navigateToDetail(DocumentSnapshot ds) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyUpdatePage(
                  ds: ds,
                )));
  }

  navigateToInfo(DocumentSnapshot ds) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyInfoPage(
                  ds: ds,
                )));
  }

  void logOut() {
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
       title: !searchState
            ? Text("Home")
            : TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.search),
                  hintText: "Search ...",
                  hintStyle: TextStyle(color: Colors.white),
                ),
              /*  onChanged: (text) {
                  //SearchMethod(text);
                  
                },*/
              ),
        actions: <Widget>[
          !searchState
              ? IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () {
                     Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return CloudFirestoreSearch(currentEmail);
                }));
                    setState(() {
                      searchState = !searchState;
                    });
                  })
              : IconButton(
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      searchState = !searchState;
                    });
                  }),
        ],
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
                      builder: (BuildContext context) =>
                          MyProducts(auth.currentUser.email)));
                }
              },
            ),
            ListTile(
              title: Text("My Cart"),
              leading: Icon(Icons.local_grocery_store),
              onTap: () {
                if (auth.currentUser != null) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          MyCart(auth.currentUser.email)));
                }
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
                            MyHomePage(currentEmail)));
                  }
                }),
            Divider(),

            ListTile(
                title: Text("Log Out"),
                leading: Icon(Icons.logout),
                onTap: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => LogInScreen()));
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

      body:  new Column(
        children: <Widget>[

 new Padding(padding: const EdgeInsets.all(4.0),
            child: Container(
                alignment: Alignment.centerLeft,
                child: new Text('Categories')),),
       
          HorizontalList(currentEmail),
            new Padding(padding: const EdgeInsets.all(4.0),
            child: Container(
                alignment: Alignment.centerLeft,
                child: new Text('')),),     
                    
     new Padding(padding: const EdgeInsets.all(5.0),
            child: Container(
                alignment: Alignment.centerLeft,
                child: new Text('Recent products')),),
          
      
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Products")
                    .snapshots(),
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
          ),
        ],
      ),

    
    );
  }
}