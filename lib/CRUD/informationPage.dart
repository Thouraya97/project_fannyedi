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
  String recipe;

  TextEditingController nameInputController;
  TextEditingController recipeInputController;
    
  Future getPost() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("colrecipes").get();
    return qn.docs;
  }

   @override
  void initState() {
    super.initState();
    recipeInputController =
        new TextEditingController(text: widget.ds.data()["recipes"]);
    nameInputController =
        new TextEditingController(text: widget.ds.data()["name"]);
    productImage = widget.ds.data()["image"];
    print(productImage);
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
                    maxLines: 10,
                    controller: recipeInputController,
                    validator: (value) {
                      if (value.isEmpty) return "Ingresa un nombre";
                    },
                    decoration: new InputDecoration(
                        hintText: "description", labelText: "recipe"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                /*FlatButton(
                  
                   Text('Add to cart'),
                   onPressed: (){

                   },
                ),*/
                
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


