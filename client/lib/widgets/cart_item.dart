import 'package:flutter/material.dart';
import 'package:stockapp/models/orderDetailModel.dart';
import 'package:stockapp/models/productModel.dart';
import 'package:stockapp/pages/cart/cart.dart';

class CartItem extends StatefulWidget {
  const CartItem(
      {super.key,
      required this.product,
      required this.handleRemoveFromCart,
      required this.calcTotal});

  final Product product;
  final Function handleRemoveFromCart;
  final Function calcTotal;

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  late int orderQuantity = 1; // The quantity the user wants to buy
  // Cart List methods
  final TextEditingController quantityController = TextEditingController();
  double itemTotal = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    itemTotal = widget.product.price * orderQuantity;
    return Container(
        margin: const EdgeInsets.only(bottom: 15),
        child: ListTile(
          onTap: () {
            widget.handleRemoveFromCart(widget.product);
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          tileColor: Colors.white,
          leading: const Icon(
            Icons.delete_sweep_outlined,
            color: Colors.red,
          ),
          title: Text(
            widget.product.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            'Total: \$${itemTotal.toStringAsFixed(2)}', // Display total for this item
          ),
          trailing: Container(
            width: 105, // Specify a fixed width
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.green,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (orderQuantity >= widget.product.stockQuantity) {
                        print("sotck quantity limited !");
                      } else {
                        orderQuantity++;
                        cartItems = cartItems.map((item) {
                          if (item.id == widget.product.id) {
                            return OrderDetail(
                                id: item.id,
                                product: item.product,
                                quantity: orderQuantity);
                          } else {
                            return item;
                          }
                        }).toList();
                        print(cartItems);
                      }
                    });
                    widget.calcTotal();
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '$orderQuantity',
                  style: const TextStyle(color: Colors.white),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (orderQuantity <= 1) {
                        print("quantity can't be less than 1");
                      } else {
                        orderQuantity--;
                        print("${widget.product.name} : $orderQuantity");
                        cartItems = cartItems.map((item) {
                          if (item.id == widget.product.id) {
                            return OrderDetail(
                                id: item.id,
                                product: item.product,
                                quantity: orderQuantity);
                          } else {
                            return item;
                          }
                        }).toList();
                        print(cartItems);
                      }
                    });
                    widget.calcTotal();
                  },
                  icon: const Icon(
                    Icons.remove,
                    color: Colors.white,
                  ),
                ),
                // ...
              ],
            ),
          ),
        ));
  }
}
