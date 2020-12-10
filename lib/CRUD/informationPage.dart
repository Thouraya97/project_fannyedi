import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyInfoPage extends StatefulWidget {
  final DocumentSnapshot ds;
  MyInfoPage({this.ds});
  @override
  _MyInfoPageState createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {
  String productImage;
  String id;
  String name;
  String price;
  String description;
  final dbcart = FirebaseFirestore.instance;
  // final dbuser = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  String cartuserID = FirebaseAuth.instance.currentUser.uid;

  TextEditingController nameInputController;
  TextEditingController priceInputController;
  TextEditingController descriptionInputController;

  Future getPost() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("colrecipes").get();
    return qn.docs;
  }

  @override
  void initState() {
    super.initState();
    priceInputController =
        new TextEditingController(text: widget.ds.data()["price"]);
    nameInputController =
        new TextEditingController(text: widget.ds.data()["name"]);
    productImage = widget.ds.data()["image"];
    print(productImage);
    price = widget.ds.data()["price"];
    name = widget.ds.data()["name"];
  }

  void addToCart() async {
    
      DocumentReference ref = await dbcart
          .collection('User')
          .doc(cartuserID)
          .collection('Cart')
          .add({
        'name': '$name',
        'price': '$price',
        'description': '$description',
        'image': '$productImage',
        'cartuserId': cartuserID
      });
      setState(() => id = ref.id);
      Navigator.of(context).pop();
      
    
  }

  @override
  Widget build(BuildContext context) {
    getPost();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffC90327),
        title: Text('Information Page'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Center(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    new Container(
                      height: 300.0,
                      width: 300.0,
                      decoration: new BoxDecoration(
                          border: new Border.all(color: Color(0xffC90327))),
                      padding: new EdgeInsets.all(5.0),
                      child: productImage == ''
                          ? Text('Edit')
                          : Image.network(productImage + '?alt=media'),
                    ),
                  ],
                ),
                //  new IniciarIcon(),
                new ListTile(
                  //leading: const Icon(Icon., color: Colors.black),
                  title: new TextFormField(
                    controller: nameInputController,
                    validator: (value) {
                      if (value.isEmpty) return "Ingresa un nombre";
                    },
                    decoration: new InputDecoration(
                        hintText: "Name", labelText: "Name"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                new ListTile(
                  leading: const Icon(Icons.list, color: Colors.black),
                  title: new TextFormField(
                    // maxLines: 10,
                    controller: priceInputController,
                    validator: (value) {
                      if (value.isEmpty) return "Name of product";
                    },
                    decoration: new InputDecoration(
                        hintText: "price", labelText: "price"),
                  ),
                ),
                Text(widget.ds.data()["price"]),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                FlatButton(
                  child: Text('Add to Cart',style: TextStyle(color: Colors.white),),
                  color: Colors.black,
                  onPressed: () {
                    addToCart();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class IniciarIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: new EdgeInsets.all(10.0),
      child: new Row(
        children: <Widget>[
          new IconoMenu(
            icon: Icons.call,
            label: "Call maker",
          ),
          new IconoMenu(
            icon: Icons.message,
            label: "Message maker",
          ),
          new IconoMenu(
            icon: Icons.place,
            label: "Maker's Adress",
          ),
        ],
      ),
    );
  }
}

class IconoMenu extends StatelessWidget {
  IconoMenu({this.icon, this.label});
  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: new Column(
        children: <Widget>[
          new Icon(
            icon,
            size: 50.0,
            color: Colors.black,
          ),
          new Text(
            label,
            style: new TextStyle(fontSize: 12.0, color: Colors.black),
          )
        ],
      ),
    );
  }
}
