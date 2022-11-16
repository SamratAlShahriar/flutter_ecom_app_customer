import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_ecom_app_customer/models/user_model.dart';

import '../models/category_model.dart';
import '../models/order_constatnt_model.dart';
import '../models/product_model.dart';

class FirebaseDbHelper {
  static final _db = FirebaseFirestore.instance;

  static Future<bool> doesUserExist(String uid) async {
    final snapshot = await _db.collection(collectionUsers).doc(uid).get();
    return snapshot.exists;
  }

  static Future<void> addUser(UserModel userModel) {
    final docRef = _db.collection(collectionUsers).doc(userModel.userId);
    return docRef.set(userModel.toMap());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllCategories() =>
      _db.collection(collectionCategory).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllProducts() =>
      _db.collection(collectionProduct).snapshots();

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getOrderConstants() =>
      _db.collection(collectionUtils).doc(documentOrderConstant).snapshots();

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getUserInfoById(
          String uid) =>
      _db.collection(collectionUsers).doc(uid).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllProductsByCategory(
          CategoryModel categoryModel) =>
      _db
          .collection(collectionProduct)
          .where('$productFieldCategory.$categoryFieldId',
              isEqualTo: categoryModel.categoryId)
          .snapshots();

  static Future<void> deleteImage(String downloadUrl) {
    return FirebaseStorage.instance.refFromURL(downloadUrl).delete();
  }

  static Future<void> updateProductField(
      String productId, Map<String, dynamic> map) {
    return _db.collection(collectionProduct).doc(productId).update(map);
  }

  static Future<void> updateUserProfileField(
      String uid, Map<String, dynamic> map) {
    return _db.collection(collectionUsers).doc(uid).update(map);
  }
}
