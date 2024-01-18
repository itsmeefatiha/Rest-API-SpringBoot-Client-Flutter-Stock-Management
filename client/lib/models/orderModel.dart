class Order {
  final int? id;
  final int client;
  final double prix;
  final String date;

  Order({
    this.id,
    required this.client,
    required this.prix,
    required this.date
  });

  factory Order.fromJson(dynamic json) {
    return Order(
      id: json['id'],
      client: json['client_id'],
      prix: json['prix'].toDouble(),
      date: json['date'].toDate()
    );
  }

  @override
  String toString() {
    return 'Order{id: $id, client: $client, prix: $prix, date: $date}';
  }
}