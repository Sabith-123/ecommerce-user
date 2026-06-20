import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String orderId;
  final String userId;
  final double subTotal;
  final double tax;
  final double deliveryCharge;
  final double totalAmount;
  final String orderStatus;
  final List<Map<String, dynamic>> items;
  final Timestamp? createdAt;
  final String address;

  OrderModel({
    required this.orderId,
    required this.userId,
    required this.subTotal,
    required this.tax,
    required this.deliveryCharge,
    required this.totalAmount,
    required this.orderStatus,
    required this.items,
    this.createdAt,
    required this.address,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderId: map['orderId'] != null ? map['orderId'] as String : '',
      userId: map['userId'] != null ? map['userId'] as String : '',
      subTotal: map['subTotal'] != null
          ? (map['subTotal'] ?? 0.0).toDouble()
          : 0.0,
      tax: map['tax'] != null ? (map['tax'] ?? 0.0).toDouble() : 0.0,
      deliveryCharge: map['deliveryCharge'] != null
          ? (map['deliveryCharge'] ?? 0.0).toDouble()
          : 0.0,
      totalAmount: map['totalAmount'] != null
          ? (map['totalAmount'] ?? 0.0).toDouble()
          : 0.0,
      orderStatus: map['orderStatus'] != null
          ? map['orderStatus'] as String
          : '',
      items: map['items'] != null
          ? List<Map<String, dynamic>>.from(map['items'])
          : [],
      createdAt: map['createdAt'] != null
          ? map['createdAt'] as Timestamp
          : null,
      address: map['address'] != null ? map['address'] as String : '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "orderId": orderId,
      "userId": userId,
      "subTotal": subTotal,
      "tax": tax,
      "deliveryCharge": deliveryCharge,
      "totalAmount": totalAmount,
      "orderStatus": orderStatus,
      "items": items,
      "createdAt": FieldValue.serverTimestamp(),
      "address": address,
    };
  }

  OrderModel copyWith({
    String? orderId,
    String? userId,
    double? subTotal,
    double? tax,
    double? deliveryCharge,
    double? totalAmount,
    String? orderStatus,
    List<Map<String, dynamic>>? items,
    String? address,
    Timestamp? createdAt,
  }) {
    return OrderModel(
      orderId: orderId ?? this.orderId,
      userId: userId ?? this.userId,
      subTotal: subTotal ?? this.subTotal,
      tax: tax ?? this.tax,
      deliveryCharge: deliveryCharge ?? this.deliveryCharge,
      totalAmount: totalAmount ?? this.totalAmount,
      orderStatus: orderStatus ?? this.orderStatus,
      items: items ?? this.items,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
