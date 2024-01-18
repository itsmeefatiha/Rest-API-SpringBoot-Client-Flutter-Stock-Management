import 'dart:convert';

import 'package:stockapp/models/clientModel.dart';
import 'package:stockapp/utils/constants.dart';
import 'package:http/http.dart' as http;

class ClientController {
  final clientApi = Constants().BuildUrl(Constants.clientApi);

  Future<List<ClientModel>> getClients() async {
    var response = await http.get(
        Uri.http(Constants.baseUrl, Constants.clientApi),
        headers: {'Content-Type': 'application/json', 'Accept': '*/*'});

    if (response.statusCode == 200) {
      // Parse JSON response
      List<dynamic> data = jsonDecode(response.body);

      // Convert to a list of Product objects
      List<ClientModel> clients = data.map((json) {
        return ClientModel(
            id: json['id'],
            first_name: json['first_name'],
            last_name: json['last_name'],
            phone_number: json['phone_number'],
            adress: json['adress'],
            email: json['email']);
      }).toList();

      return clients;
    } else {
      throw Exception('Failed to load clients');
    }
  }

  Future<ClientModel?> addClient(ClientModel client) async {
    var response = await http.post(
        Uri.http(Constants.baseUrl, Constants.clientApi),
        headers: {'Content-Type': 'application/json', 'Accept': '*/*'},
        body: jsonEncode({
          'first_name': client.first_name,
          'last_name': client.last_name,
          'phone_number': client.phone_number,
          'adress': client.adress,
          'email': client.email
        }));

    if (response.statusCode == 200) {
      // Parse JSON response
      Map<String, dynamic> data = jsonDecode(response.body);
      int id = data['id'];

      ClientModel newclient = ClientModel(
        id: id,
        first_name: data['first_name'],
        last_name: data['last_name'],
        phone_number: data['phone_number'],
        adress: data['adress'],
        email: data['email'],
      );
      return newclient;
    }

    return null;
  }

  Future<bool> updateClient(ClientModel client) async {
    print("client with updated data : ${client.id}");
    var response = await http.put(
        Uri.http(Constants.baseUrl, '${Constants.clientApi}/${client.id}'),
        headers: {'Content-Type': 'application/json', 'Accept': '*/*'},
        body: jsonEncode({
          'first_name': client.first_name,
          'last_name': client.last_name,
          'phone_number': client.phone_number,
          'adress': client.adress,
          'email': client.email
        }));
    print("response body : ${response.body}");
    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }

  Future<bool> deleteClient(ClientModel client) async {
    var response = await http.delete(
        Uri.http(Constants.baseUrl, '${Constants.clientApi}/${client.id}'),
        headers: {'Content-Type': 'application/json', 'Accept': '*/*'});
    print("response body : ${response.body}");
    print("status code : ${response.statusCode}");
    if (response.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }
}
