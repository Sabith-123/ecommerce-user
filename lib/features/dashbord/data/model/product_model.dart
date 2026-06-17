class ProductModel {
  final String productName;
  final String id;
  final double sellingPrice;
  final double mrp;
  final String imageUrl;
  final String variantId;
  final int stockQuantity;
  ProductModel({
    required this.productName,
    required this.id,
    required this.sellingPrice,
    required this.mrp,
    required this.imageUrl,
    required this.variantId,
    required this.stockQuantity,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productName: map['productName'] != null
          ? map['productName'] as String
          : '',
      id: map['id'] != null ? map['id'] as String : '',
      mrp: map['mrp'] != null ? (map['mrp'] ?? 0.0).toDouble() : 0.0,
      sellingPrice: map['sellingPrice'] != null
          ? (map['sellingPrice'] ?? 0.0).toDouble()
          : 0.0,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : '',
      variantId: map['variantId'] != null ? map['variantId'] as String : '',
      stockQuantity: map['stockQuantity'] != null
          ? map['stockQuantity'] as int
          : 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'id': id,
      'sellingPrice': sellingPrice,
      'mrp': mrp,
      'imageUrl': imageUrl,
      'variantId': variantId,
      'stockQuantity': stockQuantity,
    };
  }

  ProductModel copyWith({
    String? productName,
    String? id,
    double? sellingPrice,
    double? mrp,
    String? imageUrl,
    String? variantId,
    int? stockQuantity,
  }) {
    return ProductModel(
      productName: productName ?? this.productName,
      id: id ?? this.id,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      mrp: mrp ?? this.mrp,
      imageUrl: imageUrl ?? this.imageUrl,
      variantId: variantId ?? this.variantId,
      stockQuantity: stockQuantity ?? this.stockQuantity,
    );
  }
}
