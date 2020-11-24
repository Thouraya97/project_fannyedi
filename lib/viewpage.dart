import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_fannyedi/CRUD/addpage.dart';
import 'package:project_fannyedi/CRUD/informationPage.dart';
import 'package:project_fannyedi/CRUD/updatepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'CRUD/UploadData.dart';
import 'Login_Register/Profile.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

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

class MyHomePage extends StatefulWidget {
  String currentEmail;

  MyHomePage(this.currentEmail);

  @override
  _MyHomePageState createState() => _MyHomePageState(currentEmail);
}

class _MyHomePageState extends State<MyHomePage> {
  String currentEmail;
  FirebaseAuth auth = FirebaseAuth.instance;
  int _page = 0;

  TextEditingController recipeInputController;
  TextEditingController nameInputController;
  String id;
  final db = Firestore.instance;
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
  String recipe;
  _MyHomePageState(this.currentEmail);

  //create function for delete one register
  void deleteData(DocumentSnapshot doc) async {
    await db.collection('colrecipes').document(doc.documentID).delete();
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

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffC90327),
        title: Text('View Page1'),
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
              leading: Icon(Icons.cloud_upload),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                         builder: (BuildContext context) => MyAddPage()
                        ));
              },
            ),

            ListTile(
              title: Text("My Favorite"),
              leading: Icon(Icons.favorite),
              onTap: () {
                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => MyFavorite()));
              },
            ),

            ListTile(
                title: Text("My Profile"),
                leading: Icon(Icons.person),
                onTap: () {
                  auth.currentUser().then((value) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ProfileScreen(value.email)));
                  });
                }),
            Divider(),

            ListTile(
              title: Text("Contact US"),
              leading: Icon(Icons.email),
            ) //line
          ],
        ),
      ),
      
      body: StreamBuilder(
          stream: Firestore.instance.collection("colrecipes").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Text('"Loading...');
            }
            int length = snapshot.data.documents.length;
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, //two columns
                  mainAxisSpacing: 0.1, //space the card
                  childAspectRatio: 0.800, //space largo de cada card
                ),
                itemCount: length,
                padding: EdgeInsets.all(2.0),
                itemBuilder: (_, int index) {
                  final DocumentSnapshot doc = snapshot.data.documents[index];
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
                                    '${doc.data["image"]}' + '?alt=media',
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
                                doc.data["name"],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 19.0,
                                ),
                              ),
                              subtitle: Text(
                                doc.data["recipe"],
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
        
      /* floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.pinkAccent,
        onPressed: () {
          Route route = MaterialPageRoute(builder: (context) => MyAddPage());
          Navigator.push(context, route);
        },
      ),*/
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
