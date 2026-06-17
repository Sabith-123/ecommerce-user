import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_user_app/features/dashbord/data/model/product_model.dart';
import 'package:ecommerce_user_app/general/core/failures/main_failure.dart';
import 'package:ecommerce_user_app/general/core/typdef.dart';
import 'package:ecommerce_user_app/general/utils/firebase_collections.dart';

class ProductImpl {
  final FirebaseFirestore firestore;
  ProductImpl(this.firestore);

  FutureResult<List<ProductModel>> getProductImpl() async {
    try {
      final snapShort = await firestore
          .collection(FirebaseCollections.products)
          .get();

      final list = snapShort.docs.map((e) {
        return ProductModel.fromMap(e.data());
      }).toList();
      return right(list);
    } catch (e) {
      log(e.toString());
      return left(MainFailure.serverFailure(errorMsg: e.toString()));
    }
  }
}
