class ProductModel {
  ProductModel({
    this.id,
    required this.name,
    this.barcode,
    required this.salePrice,
    this.costPrice,
    this.imagePath,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] as String,
      barcode: map['barcode'] != null ? map['barcode'] as String : null,
      salePrice: map['sale_price'] as double,
      costPrice: map['cost_price'] != null ? map['cost_price'] as double : null,
      imagePath: map['image_path'] != null ? map['image_path'] as String : null,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
      isActive: map['is_active'] as bool,
    );
  }

  final String? id;
  final String name;
  final String? barcode;
  final double salePrice;
  final double? costPrice;
  final String? imagePath;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'name': name,
      'barcode': barcode,
      'sale_price': salePrice,
      'cost_price': costPrice,
      'image_path': imagePath,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'is_active': isActive,
    };

    if (id != null) map['id'] = id;
    if (barcode != null) map['barcode'] = barcode;
    if (costPrice != null) map['cost_price'] = costPrice;
    if (imagePath != null) map['image_path'] = imagePath;

    return map;
  }
}
