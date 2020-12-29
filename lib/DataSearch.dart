
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'CRUD/addpage.dart';
import 'CRUD/informationPage.dart';
import 'CRUD/updatepage.dart';
import 'Login_Register/LogInScreen.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}


class CommonThings {
  static Size size;
}

class CloudFirestoreSearch extends StatefulWidget {
   String currentEmail;

 CloudFirestoreSearch(this.currentEmail);
  @override
  _CloudFirestoreSearchState createState() => _CloudFirestoreSearchState(currentEmail);
}

class _CloudFirestoreSearchState extends State<CloudFirestoreSearch> {
   String currentEmail;
FirebaseAuth auth = FirebaseAuth.instance;
    String uid = FirebaseAuth.instance.currentUser.uid;

  int _page = 0;
  Future<void> Goto() async {
    if (auth.currentUser != null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          /*builder: (BuildContext context) => HomeScreen(value.email))*/
          builder: (BuildContext context) =>
              CloudFirestoreSearch(auth.currentUser.email)));
    }
  }

  String name = "";
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
 
  String product;
  _CloudFirestoreSearchState(this.currentEmail);

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

        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios , ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Card(

          child: TextField(

            decoration: InputDecoration(
                     
                prefixIcon: Icon(Icons.search, color:Color(0xffC90327) ,), hintText: 'Search...' , 
             hintStyle:         Theme.of(context).textTheme.headline6.copyWith(color: Color(0xffC90327)),

                ),
            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
          ),
        ),
      ),
      body: 
       StreamBuilder(
        stream: (name != null || name != "")
            ? FirebaseFirestore.instance
                .collection('Products')
      .where('name', isGreaterThanOrEqualTo: name)
      .where('name', isLessThan: name + 'z')
      .snapshots()

            : FirebaseFirestore.instance.collection("Products").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData) {
            return Center(
              child: Text("Error"),
            );
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
