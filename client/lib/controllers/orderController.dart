import 'dart:convert';

import 'package:stockapp/models/orderDetailModel.dart';
import 'package:stockapp/models/orderModel.dart';
import 'package:stockapp/models/productModel.dart';
import 'package:stockapp/utils/constants.dart';
import 'package:stockapp/pages/products/products.dart';
import 'package:http/http.dart' as http;

class OrderController {

  Future<bool> submitOrder(List<OrderDetail> cartItems, Order order) async {
    print("Order : $order");
    print("Cart Items : $cartItems");

    var response = await http.post(
      Uri.http(Constants.baseUrl, Constants.orderApi),
      headers: {'Content-Type': 'application/json', 'Accept': '*/*'},
      body: jsonEncode({
        "client": order.client,
        "prix": order.prix,
        "date": order.date,
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);

      Order submitedOrder = Order(
        id: jsonResponse["id"] as int,
        date: jsonResponse["date"] as String,
        prix: jsonResponse["prix"].toDouble(),
        client: jsonResponse["client"] as int,
      );

      bool success = true;

      for (OrderDetail item in cartItems) {
        print("Item : $item");

        var itemResponse = await http.post(
          Uri.http(Constants.baseUrl ,"${Constants.orderApi}/order-items/${submitedOrder.id}"),
          headers: {'Content-Type': 'application/json', 'Accept': '*/*'},
          body: jsonEncode({
            "order": submitedOrder.id,
            "product": item.product,
            "quantity": item.quantity,
          }),
        );

        if (itemResponse.statusCode != 200) {
          success = false;
          break;
        }
        print("Saved Item : ${response.body}");
        products = products.map((pr) {
          if (pr.id == item.product) {
            print("old quantity : ${pr.stockQuantity}");
            int newQnt = pr.stockQuantity - item.quantity;
            print("new quantity : $newQnt");
            return Product(
              id: item.id,
              name: pr.name,
              description: pr.description,
              price: pr.price,
              stockQuantity: newQnt,
            );
          } else {
            return pr;
          }
        }).toList();

        print("Order submitted : ${itemResponse.body}");
      }

      print("Submitted Order : $submitedOrder");

      return success;
    }


    return false;
  }
}
