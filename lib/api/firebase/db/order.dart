import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onigiri/models/index.dart';

class OrderAPI {
  static final CollectionReference _ref =
      FirebaseFirestore.instance.collection('order');

  static Future<Order> get(String id) async {
    try {
      Map<String, dynamic> dataMap = (await _ref.doc(id).get()).data();
      if (dataMap == null) {
        return null;
      }
      dataMap["id"] = id;
      return Order.fromMap(dataMap);
    } catch (e) {
      throw "Firebase Order API failed to find document [Default]/order/$id: $e";
    }
  }

  static Future<void> set(Order order) async {
    try {
      await _ref.doc(order.id).set(order.toMap(withId: false));
    } catch (e) {
      throw "Firebase Order API failed to set document [Default]/order/${order.id}: $e";
    }
  }

  static Future<void> delete(String id) async {
    try {
      await _ref.doc(id).delete();
    } catch (e) {
      throw "Firebase Order API failed to delete document [Default]/order/$id: $e";
    }
  }
}
