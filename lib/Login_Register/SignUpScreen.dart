import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:project_fannyedi/CRUD/viewpage.dart';
import 'LogInScreen.dart';
import 'LogInScreen.dart';
import 'package:project_fannyedi/viewpage.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SignUpScreen();
  }
}

class _SignUpScreen extends State<SignUpScreen> {
  bool authState = false;
  //final dbuser = Firestore.instance;
  String Idu;
  // String email = "", password = "";
  var _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController userName = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController address = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
//Firestore _firestore = Firestore.instance;
//CollectionReference _stocks = _firestore.collection('stocks');
  Future<void> register() async {
    await auth
        .createUserWithEmailAndPassword(
            email: email.text, password: password.text)
        .then((value) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => MyHomePage(value.user.email)));
    });
  final user = auth.currentUser;
    final userID = user.uid;


    FirebaseFirestore.instance.collection("User").doc(userID).set({
      "UserName": userName.text,
      //"UserId":userID,
      "UserEmail": email.text,
      "UserAddress": address.text,
      //"password": password.text,
      // "UserGender": isMale == true ? "Male" : "Female",
      "UserNumber": phoneNumber.text,
      "UserId":userID,
    });
    //setState(() => Idu = refUser.documentID);

    //FirebaseFirestore.instance.collection("User").doc(result1.user.uid).set();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      //change column to listview
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 180,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 35),
                    ),
                    Text(
                      "Welcom to our store",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(150)),
                color: Color(0xffC90327),
              ),
            ),
            Theme(
              data: ThemeData(hintColor: Colors.grey[500]),
              child: Padding(
                padding: EdgeInsets.only(top: 50, right: 20, left: 20),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter user name";
                    } else {
                      userName.text = value;
                    }
                    return null;
                  },
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "User Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.black, width: 1)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.black, width: 1)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.black, width: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.black, width: 1)),
                  ),
                ),
              ),
            ),
            Theme(
              data: ThemeData(hintColor: Colors.grey),
              child: Padding(
                padding: EdgeInsets.only(top: 10, right: 20, left: 20),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter Email";
                    } else {
                      email.text = value;
                    }
                    return null;
                  },
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.black, width: 1)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.black, width: 1)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.black, width: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.black, width: 1)),
                  ),
                ),
              ),
            ),
            Theme(
              data: ThemeData(hintColor: Colors.grey),
              child: Padding(
                padding: EdgeInsets.only(top: 10, right: 20, left: 20),
                child: TextFormField(
                  obscureText: true,
                  autocorrect: false,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter password";
                    } else if (value.length < 8) {
                      return "your password shouldn't be less than 8 character";
                    } else {
                      password.text = value;
                    }
                    return null;
                  },
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.black, width: 1)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.black, width: 1)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.black, width: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.black, width: 1)),
                  ),
                ),
              ),
            ),
            Theme(
              data: ThemeData(hintColor: Colors.grey[500]),
              child: Padding(
                padding: EdgeInsets.only(top: 50, right: 20, left: 20),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter your phone number";
                    } else {
                      phoneNumber.text = value;
                    }
                    return null;
                  },
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.black, width: 1)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.black, width: 1)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.black, width: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.black, width: 1)),
                  ),
                ),
              ),
            ),
            Theme(
              data: ThemeData(hintColor: Colors.grey[500]),
              child: Padding(
                padding: EdgeInsets.only(top: 50, right: 20, left: 20),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter your adress";
                    } else {
                      address.text = value;
                    }
                    return null;
                  },
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "Address",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.black, width: 1)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.black, width: 1)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.black, width: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.black, width: 1)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      register();
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: Colors.black,
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  padding: EdgeInsets.all(10),
                )),
            SizedBox(
              height: 20,
            ),
            Center(
                child: Column(
              children: <Widget>[
                Text(
                  "You already have an account ?",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 5,
                ),
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => LogInScreen()));
                    },
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Log In",
                          style: TextStyle(color: Colors.black),
                        ),
                        Container(
                          width: 45,
                          height: 1,
                          color: Colors.black,
                        ),
                      ],
                    ))
              ],
            ))
          ],
        ),
      ),
    );
  }
}
