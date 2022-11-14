import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../database/firebase_db_helper.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';


class ProductProvider extends ChangeNotifier {
  List<CategoryModel> categoryList = [];
  List<ProductModel> productList = [];

  void getAllCategories() {
    FirebaseDbHelper.getAllCategories().listen((snapshot) {
      categoryList = List.generate(snapshot.docs.length,
          (index) => CategoryModel.fromMap(snapshot.docs[index].data()));
      categoryList
          .sort((cat1, cat2) => cat1.categoryName.compareTo(cat2.categoryName));
      notifyListeners();
    });
  }

  void getAllProducts() {
    FirebaseDbHelper.getAllProducts().listen((snapshot) {
      productList = List.generate(snapshot.docs.length,
          (index) => ProductModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  void getAllProductsByCategory(CategoryModel categoryModel) {
    FirebaseDbHelper.getAllProductsByCategory(categoryModel).listen((snapshot) {
      productList = List.generate(snapshot.docs.length,
          (index) => ProductModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }



  Future<void> updateProductField(
      String productId, String field, dynamic value) {
    return FirebaseDbHelper.updateProductField(productId, {field: value});
  }

  Future<String> uploadImage(String thumbnailImagePath) async {
    final imageRef = FirebaseStorage.instance
        .ref('Product_Images')
        .child(DateTime.now().millisecondsSinceEpoch.toString());
    final uploadTask = imageRef.putFile(File(thumbnailImagePath));
    // uploadTask.asStream().listen((event) {
    //   event.bytesTransferred;
    //   event.totalBytes;
    // });
    final snapshot = await uploadTask.whenComplete(() => null);
    return snapshot.ref.getDownloadURL();
  }

  Future<void> deleteImage(String downloadUrl) {
    return FirebaseDbHelper.deleteImage(downloadUrl);
  }
}
