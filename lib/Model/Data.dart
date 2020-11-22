import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Data {
  String imgUrl;
  String name;
  String material;
  String price;
  String uploadid;
  String userId;

  Data(this.imgUrl, this.name, this.material, this.price, this.uploadid,
      this.userId);

  String get _imgUrl => imgUrl;

  String get _name => name;

  String get _price => price;

  String get _material => material;

  String get _uploadid => uploadid;

  String get _userId => userId;

  //String get id => _id;

  Data.fromSnapshot(DataSnapshot snapshot) {
    uploadid = snapshot.key;
    name = snapshot.value['name'];
    imgUrl = snapshot.value['imgUrl'];
    material = snapshot.value['material'];
    userId = snapshot.value['userId'];
    price = snapshot.value['price'];
  }
}
