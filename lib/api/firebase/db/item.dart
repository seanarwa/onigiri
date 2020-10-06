import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onigiri/models/index.dart';

class ItemAPI {
  static final CollectionReference _ref =
      FirebaseFirestore.instance.collection('item');

  static Future<Item> get(String id) async {
    try {
      Map<String, dynamic> dataMap = (await _ref.doc(id).get()).data();
      if (dataMap == null) {
        return null;
      }
      dataMap["id"] = id;
      return Item.fromMap(dataMap);
    } catch (e) {
      throw "Firebase Item API failed to find document [Default]/item/$id: $e";
    }
  }

  static Future<Item> add(Item item) async {
    try {
      DocumentReference ref = await _ref.add(item.toMap(withId: false));
      item.id = ref.id;
      return item;
    } catch (e) {
      throw "Firebase Item API failed to add document to [Default]/item: $e";
    }
  }

  static Future<void> set(Item item) async {
    try {
      await _ref.doc(item.id).set(item.toMap(withId: false));
    } catch (e) {
      throw "Firebase Item API failed to set document [Default]/item/${item.id}: $e";
    }
  }

  static Future<void> delete(String id) async {
    try {
      await _ref.doc(id).delete();
    } catch (e) {
      throw "Firebase Item API failed to delete document [Default]/item/$id: $e";
    }
  }
}
