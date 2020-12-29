import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart'; 

File image;
String filename;

class MyUpdatePage extends StatefulWidget {
  final DocumentSnapshot ds;
  MyUpdatePage({this.ds});
  @override
  _MyUpdatePageState createState() => _MyUpdatePageState();
}

class _MyUpdatePageState extends State<MyUpdatePage> {
  String productImage;
  TextEditingController priceInputController;
  TextEditingController nameInputController;
  TextEditingController imageInputController;
   TextEditingController descriptionInputController;

  String id;
  final db = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  String name;
  String price;
  String description;

  var selectedType;

  void updateData() async {
     DateTime now = DateTime.now();
                  String nuevoformato =
                      DateFormat('kk:mm:ss:MMMMd').format(now);
                  var fullImageName = 'nomfoto-$nuevoformato' + '.jpg';
                  var fullImageName2 = 'nomfoto-$nuevoformato' + '.jpg';

                  final Reference ref =
                      FirebaseStorage.instance.ref().child(fullImageName);
                  final UploadTask task = ref.putFile(image);

                  var part1 =
                      'https://firebasestorage.googleapis.com/v0/b/fannyedi-b1af6.appspot.com/o/'; 

                  var fullPathImage = part1 + fullImageName2;
                  print(fullPathImage);
                  FirebaseFirestore.instance
                      .collection('Products')
                      .doc(widget.ds.id)
                      .update({
                    'name': nameInputController.text,
                    'recipe': priceInputController.text,
                    'image': '$fullPathImage',
                    'category': '$selectedType',

                  });
                  Navigator.of(context).pop(); 

  }

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

  @override
  void initState() {
    super.initState();
    priceInputController =
        new TextEditingController(text: widget.ds.data()["price"]);
    nameInputController =
        new TextEditingController(text: widget.ds.data()["name"]);
         descriptionInputController =
        new TextEditingController(text: widget.ds.data()["description"]);
    productImage = widget.ds.data()["image"]; 
    print(productImage); 
  }


  Future getPosts() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("Products").get();
    return qn.docs;
  }

  @override
  Widget build(BuildContext context) {
    getPosts();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffC90327),
        title: Text('Update Page'),
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
                      height: 100.0,
                      width: 100.0,
                      decoration: new BoxDecoration(
                        border: new Border.all(color: Colors.black),
                      ),
                      padding: new EdgeInsets.all(5.0),
                      child: image == null ? Text('Add') : Image.file(image),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 2.2),
                      child: new Container(
                        height: 100.0,
                        width: 100.0,
                        decoration: new BoxDecoration(
                            border: new Border.all(color: Colors.black)),
                        padding: new EdgeInsets.all(5.0),
                        child: productImage == ''
                            ? Text('Edit')
                            : Image.network(productImage + '?alt=media'),
                      ),
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
                    controller: nameInputController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'name',
                      fillColor: Colors.grey[300],
                      filled: true,
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                    },
                    onSaved: (value) => name = value,
                  ),
                ),
                Container(
                  child: TextFormField(
                    controller: priceInputController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'price',
                      fillColor: Colors.grey[300],
                      filled: true,
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter the price of the product';
                      }
                    },
                    onSaved: (value) => price = value,
                  ),
                ),
                Container(
                  child: TextFormField(
                    controller: priceInputController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'description',
                      fillColor: Colors.grey[300],
                      filled: true,
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please describe the product';
                      }
                    },
                    onSaved: (value) => description = value,
                  ),
                ),
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
                                Colors.black
                                )
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
           
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                onPressed: updateData,
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
