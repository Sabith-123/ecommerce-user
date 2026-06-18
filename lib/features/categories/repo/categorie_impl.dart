import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_user_app/features/categories/data/model/categorie_model.dart';
import 'package:ecommerce_user_app/general/core/failures/main_failure.dart';
import 'package:ecommerce_user_app/general/core/typdef.dart';
import 'package:ecommerce_user_app/general/utils/firebase_collections.dart';

class CategorieImpl {
  FirebaseFirestore firestore;
  CategorieImpl(this.firestore);
  
  FutureResult<List<CategorieModel>> fetchCategories() async {
    try {
      final snapShot = await firestore
          .collection(FirebaseCollections.categories)
          .get();
      final list = snapShot.docs.map((e) {
        return CategorieModel.fromMap(
          e.data(),
        ); //here not use "id": e.id because id already stored in firebase documents inside.
      }).toList();
      return right(list);
    } catch (e) {
      log(e.toString());
      return left(MainFailure.serverFailure(errorMsg: e.toString()));
    }
  }
}
