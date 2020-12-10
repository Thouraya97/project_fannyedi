import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart'; //formateo hora
import 'package:firebase_auth/firebase_auth.dart';

import '../viewpage.dart';


File image;
String filename;

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Add Page',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      home: new MyAddPage(),
    );
  }
}

class CommonThings {
  static Size size;
}

class MyAddPage extends StatefulWidget {
  @override
  _MyAddPageState createState() => _MyAddPageState();
}

class _MyAddPageState extends State<MyAddPage> {
  TextEditingController descriptionInputController;
  TextEditingController nameInputController;
  TextEditingController priceInputController;
  TextEditingController cathegoryInputController;

  TextEditingController imageInputController;
  FirebaseAuth auth = FirebaseAuth.instance;
  //final userId=currentUser().uid ;

  
  String id;
  String idp;
  //final FirebaseUser user = await auth.currentUser();
  final db = FirebaseFirestore.instance;
  final dbuser = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
 var  selectedType;
  List<String> category = <String>[
    'boxs',
    'Dream catchers',
    'Colliers',
    'Bracelets',
    'Autres'

  ];
  String name;
  String price;
  String description;
//String selectedAccountType;
  pickerCam() async {
    File img = await ImagePicker.pickImage(source: ImageSource.camera);
    if (img != null) {
      image = img;
      setState(() {});
    }
  }

  pickerGallery() async {
    File img = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      image = img;
      setState(() {});
    }
  }

  Widget divider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Container(
        width: 0.8,
        color: Colors.black,
      ),
    );
  }

  void createData() async {
    DateTime now = DateTime.now();
    String nuevoformato = DateFormat('kk:mm:ss:MMMMd').format(now);
    var fullImageName = 'nomfoto-$nuevoformato' + '.jpg';
    var fullImageName2 = 'nomfoto-$nuevoformato' + '.jpg';

    final Reference ref = FirebaseStorage.instance.ref().child(fullImageName);
    final UploadTask task = ref.putFile(image);

    var part1 =
        'https://firebasestorage.googleapis.com/v0/b/fannyedi-b1af6.appspot.com/o/';

    var fullPathImage = part1 + fullImageName2;
    print(fullPathImage);
    final user = auth.currentUser;
    final ownerID = user.uid;

    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
     // var selectedAccountType ='null';
            DocumentReference ref = await db.collection('Products').add({
              'name': '$name',
              'price': '$price',
              'description': '$description',
              'image': '$fullPathImage',
              'category': '$selectedType',
              'ownerId': ownerID
      });
      setState(() => id = ref.id);
     // Navigator.of(context).pop(); 
       if (auth.currentUser != null) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      /*builder: (BuildContext context) => HomeScreen(value.email))*/
                      builder: (BuildContext context) =>
                          MyHomePage(auth.currentUser.email)));
    }
    }
     }

  @override
  Widget build(BuildContext context) {
    CommonThings.size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
        backgroundColor: Color(0xffC90327),
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    new Container(
                      height: 200.0,
                      width: 200.0,
                      decoration: new BoxDecoration(
                        border: new Border.all(color: Colors.blueAccent),
                      ),
                      padding: new EdgeInsets.all(5.0),
                      child: image == null ? Text('Add') : Image.file(image),
                    ),
                    Divider(),
                    new IconButton(
                        icon: new Icon(Icons.camera_alt), onPressed: pickerCam),
                    Divider(),
                    new IconButton(
                        icon: new Icon(Icons.image), onPressed: pickerGallery),
                  ],
                ),
                Container(
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'name',
                      fillColor: Colors.grey[300],
                      filled: true,
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter the name of the product';
                      }
                    },
                    onSaved: (value) => name = value,
                  ),
                ),
                Container(
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'price',
                      fillColor: Colors.grey[300],
                      filled: true,
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter the price of the product ';
                      }
                    },
                    onSaved: (value) => price = value,
                  ),
                ),
                Container(
                  child: TextFormField(
                    maxLines: 5,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'description',
                      fillColor: Colors.grey[300],
                      filled: true,
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please describe your product ';
                      }
                    },
                    onSaved: (value) => description = value,
                  ),
                ),
           /*  SizedBox(width: 50.0),
                  DropdownButton(
                    items: category
                        .map((value) => DropdownMenuItem(
                              child: Text(
                                value,
                                style: TextStyle(color: Color(0xff11b719)),
                              ),
                              value: value,
                            ))
                        .toList(),
                   onChanged: (selectedAccountType) {
                    
                     /*   final snackBar = SnackBar(
                                content: Text(
                                  'Selected Category  is $selectedAccountType',
                                  style: TextStyle(color: Color(0xff11b719)),
                                ),
                              );
                              Scaffold.of(context).showSnackBar(snackBar);*/
                      setState(() {
                        selectedType = selectedAccountType;
                          print('$selectedType');
                      });
                     
                    },
                    value: selectedType,
                    isExpanded: false,
                    hint: Text(
                      'Choose category Type',
                      style: TextStyle(color: Color(0xff11b719)),
                    ),
                  )
              ],
            ),
          ),
          */
            SizedBox(height: 40.0),
              StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection("category").snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      const Text("Loading.....");
                    else {
                      List<DropdownMenuItem> currencyItems = [];
                      for (int i = 0; i < snapshot.data.documents.length; i++) {
                        DocumentSnapshot snap = snapshot.data.documents[i];
                        currencyItems.add(
                          DropdownMenuItem(
                            child: Text(
                              snap.documentID,
                              style: TextStyle
                              ( color: (
                                Colors.black)
                                ),
                            ),
                            value: "${snap.documentID}",
                          ),
                        );
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          SizedBox(width: 50.0),
                          DropdownButton(
                            items: currencyItems,
                            onChanged: (selectedAccountType) {
                            
                            
                              setState(() {
                                selectedType = selectedAccountType;          

                              });
                            },
                           value: selectedType,
                            isExpanded: false,
                            hint: new Text(
                              "Choose Category  Type",
                            style: TextStyle( 
                              color: (
                                Colors.black)
                                ),
                                            
                                            ),
                                                
                          ),
                        ],
                      );
                    }
                  }), 
              ],
            ),
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                onPressed: createData,
                child: Text('Create', style: TextStyle(color: Colors.white)),
                color: Colors.black,
              ),
            ],
          )
        ],
      ),
    );
  }
}
