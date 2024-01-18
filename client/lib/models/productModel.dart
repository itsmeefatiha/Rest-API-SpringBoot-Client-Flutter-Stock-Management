class Product {
  final int? id;
  final String name;
  final String description;
  final double price;
  final int stockQuantity;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stockQuantity
  });

  factory Product.fromJson(dynamic json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      stockQuantity: json['stock_qte'] as int,
    );
  }

  @override
  String toString() {
    return 'Product{id: $id, name: $name, description: $description, price: $price, stockQuantity: $stockQuantity}';
  }
  
}
