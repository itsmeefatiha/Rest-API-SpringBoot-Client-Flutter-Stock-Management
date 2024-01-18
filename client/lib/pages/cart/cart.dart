import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stockapp/controllers/clientController.dart';
import 'package:stockapp/controllers/orderController.dart';
import 'package:stockapp/models/orderModel.dart';
import 'package:stockapp/models/productModel.dart';
import 'package:stockapp/models/orderDetailModel.dart';
import 'package:stockapp/pages/cart/thankspage.dart';
// ignore: unused_import
import 'package:stockapp/pages/products/products.dart';
import 'package:stockapp/widgets/cart_item.dart';
import 'package:stockapp/models/clientModel.dart';

// ignore: non_constant_identifier_names
List<Product> CartProducts = [];
List<OrderDetail> cartItems = [];
List<dynamic> orderDeatils = [];
List<ClientModel> clients = [];

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<ClientModel> clients = [];
  ClientModel _currentSelectedValue = ClientModel(
    id: null,
    first_name: null,
    last_name: null,
    phone_number: null,
    adress: null,
    email: null,
  );
  double cartTotal = 123.00;

  @override
  void initState() {
    super.initState();
    calcTotal();
    _loadClients();
  }

  void calcTotal() {
    double total = 0;
    for (OrderDetail item in cartItems) {
      CartProducts.forEach((pr) {
        if (pr.id == item.product) {
          int qnt = item.quantity as int;
          total += pr.price * qnt;
        }
      });
    }

    setState(() {
      cartTotal = total;
    });
    print(cartTotal);
  }

  Future<void> _loadClients() async {
    try {
      // Perform asynchronous operation outside of setState
      List<ClientModel> loadedClients = await ClientController().getClients();

      // Update the state inside setState
      setState(() {
        clients = loadedClients;
        _currentSelectedValue = clients[0];
        print("_currentSelectedValue : $_currentSelectedValue");
      });
    } catch (e) {
      print("Error while loading clients: $e");
    }
  }

  void clearCart() {
    print("clear cart");
    setState(() {
      CartProducts = [];
      cartTotal = 0.00;
      cartItems = [];
    });
  }

  void handleRemoveFromCart(Product pr) {
    setState(() {
      if (CartProducts.contains(pr)) {
        CartProducts.remove(pr);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    calcTotal();
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 22.0, right: 10, left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(1.0),
                child: ElevatedButton(
                  onPressed: () async {
                    print("order submiting");
                    print("client id : ${_currentSelectedValue.id}");
                    
                    DateTime now = DateTime.now();
                    String dateString = now.toString();

                    int client_id = _currentSelectedValue.id as int;

                    bool isSubmited = await OrderController().submitOrder(
                        cartItems,
                        Order(
                            client: client_id,
                            prix: cartTotal,
                            date: dateString));

                    if (isSubmited) {
                      clearCart();
                      
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ThankYouPage(),
                        ),
                      );
                    } else {}
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.green,
                    elevation: 0.0,
                  ),
                  child: const Text(
                    "Order",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(1.0),
                child: ElevatedButton(
                  onPressed: () {
                    clearCart();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.red,
                    elevation: 0.0,
                  ),
                  child: const Text(
                    "Clear Cart",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(
          'Cart',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              "Welcome to cart page! All the CartProducts you had select will be here.",
              style: TextStyle(
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5.0),
            SingleChildScrollView(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                InputDecorator(
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(
                      color: Colors.redAccent,
                      fontSize: 16.0,
                    ),
                    hintText: 'Please select a client',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  // ignore: unnecessary_null_comparison
                  isEmpty: _currentSelectedValue == null,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<ClientModel>(
                      value:
                          _currentSelectedValue, // Set the value to the entire ClientModel object or any specific property like id
                      isDense: true,
                      onChanged: (ClientModel? client) {
                        setState(() {
                          _currentSelectedValue = client!;
                        });
                      },
                      items: clients.map(
                        (ClientModel cl) {
                          return DropdownMenuItem<ClientModel>(
                            value:
                                cl, // Set the value to the entire ClientModel object or any specific property like id
                            child: Text("${cl.first_name} ${cl.last_name}"),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                for (Product pr in CartProducts)
                  CartItem(
                      product: pr,
                      handleRemoveFromCart: handleRemoveFromCart,
                      calcTotal: calcTotal),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "TOTAL :",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "$cartTotal",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ],
            ),
            )
          ],
        ),
      ),
      ),
    );
  }
}
