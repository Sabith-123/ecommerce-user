import 'package:ecommerce_user_app/features/dashbord/data/model/product_model.dart';

class CartModel {
  final ProductModel product;
  final int quantity;

  CartModel({required this.product, required this.quantity});

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      product: ProductModel.fromMap(map['product'] as Map<String, dynamic>),
      quantity: map['quantity'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {'product': product.toMap(), 'quantity': quantity};
  }

  CartModel copyWith({ProductModel? product, int? quantity}) {
    return CartModel(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}
