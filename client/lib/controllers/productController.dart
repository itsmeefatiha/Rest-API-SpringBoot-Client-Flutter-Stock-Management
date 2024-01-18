import 'dart:convert';

import 'package:stockapp/models/productModel.dart';
import 'package:stockapp/utils/constants.dart';
import 'package:http/http.dart' as http;

class ProductController {
  final productApi = Constants().BuildUrl(Constants.productsApi);

  Future<List<Product>> getProducts() async {
    var response = await http.get(
      Uri.http(Constants.baseUrl, Constants.productsApi),
      headers: {'Content-Type': 'application/json', 'Accept': '*/*'},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);

      List<Product> products = data.map((json) {
        return Product(
            id: json['id'],
            name: json['name'],
            description: json['description'] ?? "",
            price: json['price'].toDouble(),
            stockQuantity: json['stock_qte']);
      }).toList();

      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<Product?> addProduct(Product product) async {
    var response = await http.post(
      Uri.http(Constants.baseUrl, Constants.productsApi),
      headers: {'Content-Type': 'application/json', 'Accept': '*/*'},
      body: jsonEncode({
        "name": product.name,
        "description": product.description,
        "price": product.price,
        "stock_qte": product.stockQuantity,
      }),
    );

    if (response.statusCode == 200) {
      print(response.body);
      try {
        Map<String, dynamic> jsonResponse = json.decode(response.body);

        int id = jsonResponse['id'];
        int stockQuantity = jsonResponse['stock_qte'];

        Product newProduct = Product(
          id: id,
          name: jsonResponse['name'],
          description: jsonResponse['description'],
          price: jsonResponse['price'].toDouble(),
          stockQuantity: stockQuantity,
        );

        return newProduct;
      } catch (e) {
        print("Error while converting the product: $e");
      }
    } else {
      throw Exception('Failed to load products');
    }
    return null;
  }

  Future<bool> UpdateProduct(Product product) async {
    try {
      var response = await http.put(
        Uri.http(Constants.baseUrl, "${Constants.productsApi}/${product.id}"),
        headers: {'Content-Type': 'application/json', 'Accept': '*/*'},
        body: jsonEncode({
          "id": product.id,
          "name": product.name,
          "description": product.description,
          "price": product.price,
          "stock_qte": product.stockQuantity,
        }),
      );

      print(response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("update error : $e");
      return false;
    }
  }

  Future<bool> deleteProduct(Product product) async {
    try {
      var response = await http.delete(
          Uri.http(Constants.baseUrl, "${Constants.productsApi}/${product.id}"),
          headers: {'Content-Type': 'application/json', 'Accept': '*/*'});

      if (response.statusCode == 200) {
        print("deleted from controller !");
        return true;
      } else {
        print("did not deleted from controller !");
        print(response.body);
        return false;
      }
    } catch (e) {
      print("Delete error : $e");
      return false;
    }
  }
}
