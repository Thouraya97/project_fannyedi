/*import 'dart:collection';
import 'dart:io';
import'package:project_fannyedi/HomeScreen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'MyFavourite.dart';
import 'package:project_fannyedi/Login_Register/LogInScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
class UploadData extends StatefulWidget {
  @override
  _UploadDataState createState() => _UploadDataState();
}

class _UploadDataState extends State<UploadData> {
  File imageFile;
    FirebaseAuth auth =FirebaseAuth.instance;

  var formKey = GlobalKey<FormState>();
  String name, material, price;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        backgroundColor: Color(0xffC90327),
        title: Text(
          "Upload Data",
          style: TextStyle(color: Color(0xffffffff)),
        ),
      ),
      body: Form(
        key: formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 15)),
              Container(
                child: imageFile == null
                    ? FlatButton(
                        onPressed: () {
                          _showDialog();
                        },
                        child: Icon(
                          Icons.add_a_photo,
                          size: 80,
                          color: Color(0xffC90327),
                        ))
                    : Image.file(
                        imageFile,
                        width: 200,
                        height: 100,
                      ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    flex: 1,
                    child: Theme(
                      data: ThemeData(
                        hintColor: Colors.grey,
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please write the name of production";
                          } else {
                            name = value;
                          }
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            labelText: "Name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Color(0xffC90327), width: 1)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Color(0xffC90327), width: 1)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Color(0xffC90327), width: 1)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Color(0xffC90327), width: 1))),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    flex: 1,
                    child: Theme(
                      data: ThemeData(
                        hintColor: Colors.grey,
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please write the material of production";
                          } else {
                            material = value;
                          }
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            labelText: "Material",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Color(0xffC90327), width: 1)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Color(0xffC90327), width: 1)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Color(0xffC90327), width: 1)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Color(0xffC90327), width: 1))),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    flex: 1,
                    child: Theme(
                      data: ThemeData(
                        hintColor: Colors.grey
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please write the price of production";
                          } else {
                            price = value;
                          }
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            labelText: "Price",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Color(0xffC90327), width: 1)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Color(0xffC90327), width: 1)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Color(0xffC90327), width: 1)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Color(0xffC90327), width: 1))),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                onPressed: () {
                  if (imageFile == null) {
                    Fluttertoast.showToast(
                        msg: "Please select an image",
                        gravity: ToastGravity.CENTER,
                        toastLength: Toast.LENGTH_LONG,
                        timeInSecForIosWeb: 2);
                  } else {
                    upload();
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Color(0xff2E001F),
                child: Text(
                  "Upload",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Color(0xff2E001F),
        backgroundColor: Colors.white,
        buttonBackgroundColor: Color(0xff2E001F),
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
        animationDuration: Duration(milliseconds: 200),
        onTap: (index) {
          setState(() {
              if(index==0){
             auth.currentUser().then((value) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (BuildContext context) => HomeScreen(value.email)));
    });
  }
          
          if(index==2)
          {
             Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (BuildContext context) => UploadData()));
                    
          }
          if(index==1){
             Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => MyFavorite()));
          }
        
          });
        },
      ),
    );
  }

  Future<void> _showDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
            title: Text("You want take a photo from ?"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Gallary"),
                    onTap: () {
                      openGallary();
                    },
                  ),
                  Padding(padding: EdgeInsets.only(top: 8)),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      openCamera();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> openGallary() async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
    });
  }

  Future<void> openCamera() async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
    });
  }

  Future<void> upload() async {
    if (formKey.currentState.validate()) {
      StorageReference reference = FirebaseStorage.instance
          .ref()
          .child("images")
          .child(new DateTime.now().millisecondsSinceEpoch.toString() +
              "." +
              imageFile.path);
      StorageUploadTask uploadTask = reference.putFile(imageFile);
     // StorageUploadTask updateTask = reference.updateMetadata(imageFile);
      var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
      String url = imageUrl.toString();
      DatabaseReference databaseReference =
          FirebaseDatabase.instance.reference().child("Data");
      String uploadId = databaseReference.push().key;
      HashMap map = new HashMap();
      map["name"] = name;
      map["material"] = material;
      map["price"] = price;
      map["imgUrl"] = url;

      databaseReference.child(uploadId).set(map);
       auth.currentUser().then((value) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            //  builder: (BuildContext context) => HomeScreen(value.email)));
    });

    }
  }
  
  Future<void> currentEmail() async {
    await auth.currentUser().then((value) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            //  builder: (BuildContext context) => HomeScreen(value.email)));
    });
  }
}
*/