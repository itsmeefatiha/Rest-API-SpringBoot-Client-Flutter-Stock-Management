class ClientModel {
  final int? id;
  final String? first_name;
  final String? last_name;
  final String? phone_number;
  final String? adress;
  final String? email;

  ClientModel({
    this.id,
    required this.first_name,
    required this.last_name,
    required this.phone_number,
    required this.adress,
    required this.email,
  });

  factory ClientModel.fromJson(dynamic json) {
    return ClientModel(
      id: json['id'] ?? null,
      first_name: json['first_name'],
      last_name: json['last_name'],
      phone_number: json['phone_number'],
      adress: json['adress'],
      email: json['email'],
    );
  }

  @override
  String toString() {
    return 'Product{id: $id, first_name: $first_name, last_name: $last_name, phone_number: $phone_number, adress: $adress, email: $email}';
  }
}
