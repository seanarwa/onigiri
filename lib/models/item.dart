import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  String id;
  Timestamp createdAt;
  Timestamp updatedAt;
  String name;
  int price; // price in cents

  Item({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.price,
  });

  Item.fromMap(Map<String, dynamic> map) {
    this.id = map["id"] as String;
    this.createdAt = map["createdAt"] as Timestamp;
    this.updatedAt = map["updatedAt"] as Timestamp;
    this.name = map["name"] as String;
    this.price = map["price"] as int;
  }

  Map<String, dynamic> toMap({bool withId = true}) {
    Map<String, dynamic> result = {
      'createdAt': this.createdAt,
      'updatedAt': this.updatedAt,
      'name': this.name,
      'price': this.price,
    };

    if (withId) {
      result['id'] = this.id;
    }

    return result;
  }

  @override
  String toString() {
    return '${this.runtimeType.toString}(${toMap().toString()})';
  }
}
