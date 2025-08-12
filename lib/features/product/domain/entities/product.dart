class Product {
  final String id;
  final String name;
  final String? barcode;
  final double salePrice;
  final double? costPrice;
  final String? imagePath;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;

  Product({
    required this.id,
    required this.name,
    this.barcode,
    required this.salePrice,
    this.costPrice,
    this.imagePath,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
  });

  Product copyWith({
    String? id,
    String? name,
    String? barcode,
    double? salePrice,
    double? costPrice,
    String? imagePath,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      barcode: barcode ?? this.barcode,
      salePrice: salePrice ?? this.salePrice,
      costPrice: costPrice ?? this.costPrice,
      imagePath: imagePath ?? this.imagePath,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
    );
  }
}
