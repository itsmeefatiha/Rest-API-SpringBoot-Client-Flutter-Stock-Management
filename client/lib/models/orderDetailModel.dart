class OrderDetail {
  final int? id;
  final int? order;
  final int? product;
  late final int quantity;

  OrderDetail(
      {this.id, this.order, required this.product, required this.quantity});

  factory OrderDetail.fromJson(dynamic json) {
    return OrderDetail(
        id: json['id'],
        order: json['order_id'],
        product: json['product_id'],
        quantity: json['quantity']);
  }

  @override
  String toString() {
    return 'OrderDetail{id: $id, order: $order, product: $product, quantity: $quantity}';
  }
}
