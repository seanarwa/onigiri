import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Order {
  String id;
  String name;
  DocumentReference itemRef;
  int quantity;

  Order({
    @required this.id,
    this.name,
    this.itemRef,
    this.quantity,
  });

  Order.fromMap(Map<String, dynamic> map) {
    this.id = map["id"] as String;
    this.name = map["name"] as String;
    this.itemRef = map["itemRef"] as DocumentReference;
    this.quantity = map["quantity"] as int;
  }

  Map<String, dynamic> toMap({bool withId = true}) {
    Map<String, dynamic> result = {
      'name': this.name,
      'itemRef': this.itemRef,
      'quantity': this.quantity,
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
