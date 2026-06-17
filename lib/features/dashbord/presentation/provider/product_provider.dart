import 'dart:developer';
import 'package:ecommerce_user_app/features/dashbord/data/model/product_model.dart';
import 'package:ecommerce_user_app/features/dashbord/repo/product_impl.dart';
import 'package:ecommerce_user_app/general/widgets/custom_toast.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  final ProductImpl productImpl;
  ProductProvider(this.productImpl);

  List<ProductModel> productItemsList = [];

  bool isLoadProduct = false;

  Future<void> fetchProductFun() async {
    // 🟢 FIX: If we already have data, don't call Firestore again!
    // if (productItemsList.isNotEmpty) return;
    isLoadProduct = true;
    notifyListeners();
    try {
      final result = await productImpl.getProductImpl();
      result.fold(
        (l) {
          log(l.errorMsg);
          CToast.error(msg: 'field to fetch product');
        },
        (r) {
          productItemsList = r;
        },
      );
    } finally {
      isLoadProduct = false;
      notifyListeners();
    }
  }
}
