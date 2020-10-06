import 'package:flutter/material.dart';
import 'package:onigiri/models/index.dart';

class Order {
  String id;
  int createdAt;
  int updatedAt;
  Map<Item, int> items;

  Order({
    @required this.id,
    this.createdAt,
    this.updatedAt,
    this.items,
  });

  int getTotal() {
    int result = 0;
    items.forEach((item, quantity) {
      result += item.price * quantity;
    });
    return result;
  }

  Order.fromMap(Map<String, dynamic> map) {
    this.id = map["id"] as String;
    this.createdAt = map["createdAt"] as int;
    this.updatedAt = map["updatedAt"] as int;
    this.items = map["items"] as Map<Item, int>;
  }

  Map<String, dynamic> toMap({bool withId = true}) {
    Map<String, dynamic> result = {
      'createdAt': this.createdAt,
      'updatedAt': this.updatedAt,
      'items': this.items,
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
