import 'package:ecommerce_user_app/features/dashbord/data/model/cart_model.dart';
import 'package:ecommerce_user_app/features/dashbord/data/model/product_model.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<CartModel> cartItemsList = [];

  void addToCart(ProductModel productModelItem) {
    final index = cartItemsList.indexWhere((e) {
      return e.product.id == productModelItem.id;
    });
    if (index != -1) // Product already exists in cart
    {
      cartItemsList[index] = cartItemsList[index].copyWith(
        quantity: cartItemsList[index].quantity + 1,
      );
    } else {
      //first time add a product into cart
      cartItemsList.add(CartModel(product: productModelItem, quantity: 1));
    }
    notifyListeners();
  }

  int getQuantity(String productId) {
    final index = cartItemsList.indexWhere((e) {
      return e.product.id == productId;
    });
    if (index == -1) {
      return 0;
    }
    return cartItemsList[index].quantity;
  }

  void removeFromCart(ProductModel productModelItem) {
    final index = cartItemsList.indexWhere((e) {
      return e.product.id == productModelItem.id;
    });
    // Product not found in cart
    if (index == -1) return;
    // Quantity greater than 1
    if (cartItemsList[index].quantity > 1) {
      cartItemsList[index] = cartItemsList[index].copyWith(
        quantity: cartItemsList[index].quantity - 1,
      );
    } else {
      // Remove product when quantity becomes 0
      cartItemsList.removeAt(index);
    }
    notifyListeners();
  }
}
