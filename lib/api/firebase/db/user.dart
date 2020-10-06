import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onigiri/models/index.dart';

class UserAPI {
  static final CollectionReference _ref =
      FirebaseFirestore.instance.collection('user');

  static Future<User> get(String id) async {
    try {
      Map<String, dynamic> dataMap = (await _ref.doc(id).get()).data();
      if (dataMap == null) {
        return null;
      }
      dataMap["id"] = id;
      return User.fromMap(dataMap);
    } catch (e) {
      throw "Firebase User API failed to find document [Default]/user/$id: $e";
    }
  }

  static Future<User> add(User user) async {
    try {
      DocumentReference ref = await _ref.add(user.toMap(withId: false));
      user.id = ref.id;
      return user;
    } catch (e) {
      throw "Firebase User API failed to add document to [Default]/user: $e";
    }
  }

  static Future<void> set(User user) async {
    try {
      await _ref.doc(user.id).set(user.toMap(withId: false));
    } catch (e) {
      throw "Firebase User API failed to set document [Default]/user/${user.id}: $e";
    }
  }

  static Future<void> delete(String id) async {
    try {
      await _ref.doc(id).delete();
    } catch (e) {
      throw "Firebase User API failed to delete document [Default]/user/$id: $e";
    }
  }
}
