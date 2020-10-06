import 'package:flutter/material.dart';

class Item {
  String id;
  String name;
  int price; // price in cents

  Item({
    @required this.id,
    this.name,
    this.price,
  });

  Item.fromMap(Map<String, dynamic> map) {
    this.id = map["id"] as String;
    this.name = map["name"] as String;
    this.price = map["price"] as int;
  }

  Map<String, dynamic> toMap({bool withId = true}) {
    Map<String, dynamic> result = {
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
