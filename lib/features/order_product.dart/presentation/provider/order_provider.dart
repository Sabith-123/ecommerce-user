import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:ecommerce_user_app/features/order_product.dart/data/model/order_model.dart';
import 'package:ecommerce_user_app/features/order_product.dart/repo/order_impl.dart';
import 'package:flutter/foundation.dart';

class OrderProvider extends ChangeNotifier {
  final OrderImpl orderImpl;
  OrderProvider(this.orderImpl);

  bool isCreateOrderLoading = false;

  Future<void> createOrderFun({required OrderModel orderModel}) async {
    isCreateOrderLoading = true;
    notifyListeners();
    try {
      final result = await orderImpl.createOrder(orderMOdel: orderModel);
      result.fold(
        (l) {
          log(l.errorMsg);
          left('field to create the order');
        },
        (r) {
          right('Order Created Successfully');
        },
      );
    } finally {
      isCreateOrderLoading = false;
      notifyListeners();
    }
  }
}
