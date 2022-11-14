import 'package:flutter/material.dart';

import '../database/firebase_db_helper.dart';
import '../models/order_constatnt_model.dart';

class OrderProvider extends ChangeNotifier{
  OrderConstantModel orderConstantModel = OrderConstantModel();

  getOrderConstants() {
    FirebaseDbHelper.getOrderConstants().listen((snapshot) {
      if(snapshot.exists) {
        orderConstantModel = OrderConstantModel.fromMap(snapshot.data()!);
        notifyListeners();
      }
    });
  }

}