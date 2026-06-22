import 'dart:developer';

import 'package:ecommerce_user_app/features/dashbord/presentation/provider/cart_provider.dart';
import 'package:ecommerce_user_app/features/order_product.dart/data/model/order_model.dart';
import 'package:ecommerce_user_app/features/order_product.dart/repo/order_impl.dart';
import 'package:ecommerce_user_app/general/widgets/custom_toast.dart';
import 'package:flutter/foundation.dart';

class OrderProvider extends ChangeNotifier {
  final OrderImpl orderImpl;
  OrderProvider(this.orderImpl);

  bool isCreateOrderLoading = false;
  bool isFetchOrderLoading = false;
  List<OrderModel> orderHistoryList = [];

  Future<void> createOrderFun({
    required String userId,
    required String address,
    required CartProvider cartProvider,
  }) async {
    if (cartProvider.cartItemsList.isEmpty) {
      CToast.error(msg: "Your cart is empty");
      return;
    }

    isCreateOrderLoading = true;
    notifyListeners();
    try {
      // 1. Do all the math here in the provider
      final taxAmount = (cartProvider.subTotal * cartProvider.tax) / 100;
      final finalTotal =
          cartProvider.subTotal + taxAmount + cartProvider.deliveyCharge;

      // Order items
      final List<Map<String, dynamic>> orderItems = cartProvider.cartItemsList
          .map((e) {
            return {
              'productId': e.product.id,
              'productName': e.product.productName,
              'price': e.product.sellingPrice,
              'quantity': e.quantity,
              'variantId': e.product.variantId,
              'imageUrl': e.product.imageUrl,
            };
          })
          .toList();

      // Create order model
      final newOrder = OrderModel(
        orderId: '',
        userId: userId,
        subTotal: cartProvider.subTotal,
        tax: taxAmount,
        deliveryCharge: cartProvider.deliveyCharge.toDouble(),
        totalAmount: finalTotal,
        orderStatus: 'pending',
        items: orderItems,
        address: address,
      );
      // Save order to firebase

      final result = await orderImpl.createOrder(orderMOdel: newOrder);
      result.fold(
        (l) {
          log(l.errorMsg);
          CToast.error(msg: 'Failed to place order. Please try again.');
        },
        (r) {
          CToast.success(msg: 'Order placed successfully');
          log('Order Created Successfully');
          log('Order Id : ${r.orderId}');

          // Clear cart after successful order
          cartProvider.cartItemsList.clear();
          // 2. ADD TO LOCAL CACHE IMMEDIATELY!
          // We use .insert(0, ...) instead of .add() so the newest order appears at the top of the screen!
          orderHistoryList.insert(0, r);
        },
      );
    } catch (e) {
      log(e.toString());
    } finally {
      isCreateOrderLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchOrderDetailsFun({required String userId}) async {
    // 1. SMART CACHE CHECK: Stop here if we already have the data!
    if (orderHistoryList.isNotEmpty) {
      log('Orders already loaded locally. 0 Firebase reads spent!');
      return;
    }
    isFetchOrderLoading = true;
    notifyListeners();
    try {
      final result = await orderImpl.fetchOrderDetails(userId: userId);
      result.fold(
        (l) {
          log('ERROR => ${l.errorMsg}');
          log(l.errorMsg);
          CToast.error(msg: 'Failed to load orders. Please try again.');
        },
        (r) {
          orderHistoryList = r;
        },
      );
    } catch (e, st) {
      log(e.toString());
      log(st.toString());
    } finally {
      isFetchOrderLoading = false;
      notifyListeners();
    }
  }
}
