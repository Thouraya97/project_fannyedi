import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

//import 'package:flutter/material.dart';
import 'package:project_fannyedi/Login_Register/LogInScreen.dart';
import 'package:project_fannyedi/Model/Data.dart';
//import 'LogInScreen.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:project_fannyedi/CRUD/UploadData.dart';
import 'package:project_fannyedi/CRUD/MyFavourite.dart';

class ProfileScreen extends StatefulWidget {
  String currentEmail;

  ProfileScreen(this.currentEmail);

  @override
  _ProfileScreenState createState() => _ProfileScreenState(currentEmail);
}

class _ProfileScreenState extends State<ProfileScreen> {
  String currentEmail;
  File imageProfile;
  // FirebaseAuth auth =FirebaseAuth.instance;

  var formKey = GlobalKey<FormState>();

  FirebaseAuth auth = FirebaseAuth.instance;
  _ProfileScreenState(this.currentEmail);
  Future<void> logOut() async {
    auth.signOut().then((value) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => LogInScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffffffff),
        appBar: AppBar(
          backgroundColor: Color(0xffC90327),
          title: Text("Profile"),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                logOut();
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
            )
            //label: Text("Log out"))
          ],
        ),
        body: Center(
          child: Column(
            children: [
              Row(
                //decoration : new BoxDecoration() ,
                children: <Widget>[
                  Container(
                    color:Colors.grey ,
                    child: imageProfile == null
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
                            imageProfile,
                            width: 200,
                            height: 100,
                          ),
                          
                  ),
                  Container(
                    child: Text(
                      currentEmail,
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
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
                      uploadimage();
                    },
                  ),
                  Padding(padding: EdgeInsets.only(top: 8)),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      openCamera();
                      uploadimage();
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
      imageProfile = picture;
    });
  }

  Future<void> openCamera() async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageProfile = picture;
    });
  }

  Future<void> uploadimage() async {
    if (formKey.currentState.validate()) {
      StorageReference reference = FirebaseStorage.instance
          .ref()
          .child("images")
          .child(new DateTime.now().millisecondsSinceEpoch.toString() +
              "." +
              imageProfile.path);
      StorageUploadTask uploadTask = reference.putFile(imageProfile);
    }
  }
}
