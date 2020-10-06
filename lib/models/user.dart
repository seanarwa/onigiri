import 'package:flutter/material.dart';

class User {
  String id;
  String displayName;
  String email;
  String photoUrl;

  User({
    @required this.id,
    this.displayName,
    this.email,
    this.photoUrl,
  });

  User.fromMap(Map<String, dynamic> map) {
    this.id = map["id"] as String;
    this.displayName = map["displayName"] as String;
    this.email = map["email"] as String;
    this.photoUrl = map["photoUrl"] as String;
  }

  Map<String, dynamic> toMap({bool withId = true}) {
    Map<String, dynamic> result = {
      'displayName': this.displayName,
      'email': this.email,
      'photoUrl': this.photoUrl,
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
