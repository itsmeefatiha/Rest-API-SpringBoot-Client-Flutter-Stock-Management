import 'package:flutter/material.dart';
import 'package:stockapp/models/productModel.dart';

class CartList extends StatelessWidget {
  const CartList(
      {super.key,
      required this.product,
      required this.context,
      required this.quantityController,
      required this.quantity,
      required this.addQuantity,
      required this.reduceQuantity,
      required this.onQuantityChanged,
      required this.handleRemoveFromCart});

  final Product product;
  final BuildContext context;
  final TextEditingController quantityController;
  final int quantity;
  final VoidCallback addQuantity;
  final VoidCallback reduceQuantity;
  final Function handleRemoveFromCart;
  final VoidCallback onQuantityChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 15),
        child: ListTile(
          onTap: () {
            handleRemoveFromCart(product);
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          tileColor: Colors.white,
          leading: const Icon(
            Icons.delete_sweep_outlined,
          ),
          title: Text(
            product.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          // trailing: Container(
          //   child: TextFormField(
          //     controller: quantityController,
          //     decoration: InputDecoration(
          //       labelText: 'Quantity',
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(10.0),
          //       ),
          //       suffixIcon: Row(
          //         mainAxisSize: MainAxisSize.min,
          //         children: [
          //           IconButton(
          //             icon: Icon(Icons.remove),
          //             onPressed: () {
          //               addQuantity();
          //             },
          //           ),
          //           IconButton(
          //             icon: Icon(Icons.add),
          //             onPressed: () {
          //               reduceQuantity();
          //             },
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          trailing: Container(
          width: 40.0, // Adjust the width as needed
          child: TextField(
            controller: quantityController,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(vertical: 4.0),
            ),
          ),
        ),
        ));
  }
}
