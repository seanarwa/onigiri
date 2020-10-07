import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  Timestamp createdAt;
  Timestamp updatedAt;
  String displayName;
  String email;
  String photoUrl;

  User({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.displayName,
    this.email,
    this.photoUrl,
  });

  User.fromMap(Map<String, dynamic> map) {
    this.id = map["id"] as String;
    this.createdAt = map["createdAt"] as Timestamp;
    this.updatedAt = map["updatedAt"] as Timestamp;
    this.displayName = map["displayName"] as String;
    this.email = map["email"] as String;
    this.photoUrl = map["photoUrl"] as String;
  }

  Map<String, dynamic> toMap({bool withId = true}) {
    Map<String, dynamic> result = {
      'createdAt': this.createdAt,
      'updatedAt': this.updatedAt,
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
