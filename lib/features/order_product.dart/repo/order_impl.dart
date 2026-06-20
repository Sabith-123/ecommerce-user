import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_user_app/features/order_product.dart/data/model/order_model.dart';
import 'package:ecommerce_user_app/general/core/failures/main_failure.dart';
import 'package:ecommerce_user_app/general/core/typdef.dart';
import 'package:ecommerce_user_app/general/utils/firebase_collections.dart';

class OrderImpl {
  final FirebaseFirestore firestore;
  // Constructor receives FirebaseFirestore instance
  OrderImpl(this.firestore);

  FutureResult<OrderModel> createOrder({required OrderModel orderMOdel}) async {
    try {
      // Firestore generates unique document id
      final docRef = firestore.collection(FirebaseCollections.orders).doc();
      // Add generated order id to model
      final result = orderMOdel.copyWith(orderId: docRef.id);
      // Save order in Firestore
      await docRef.set(result.toMap());
      return right(result);
    } catch (e) {
      log(e.toString());
      return left(MainFailure.serverFailure(errorMsg: e.toString()));
    }
  }
}
