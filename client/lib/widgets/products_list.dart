import 'package:flutter/material.dart';
import 'package:stockapp/controllers/productController.dart';
import 'package:stockapp/models/orderDetailModel.dart';
import 'package:stockapp/models/productModel.dart';
import 'package:stockapp/pages/cart/cart.dart';
import 'package:stockapp/pages/products/updateProduct.dart';
import 'package:stockapp/pages/products/products.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({super.key, required this.product, required this.context});

  final Product product;
  final BuildContext context;

  void _handleAddToCart(Product product) {
    // Check if the product is already in the array
    if (!CartProducts.contains(product)) {
      print("added to cart");
      CartProducts.add(product);
      cartItems.add(OrderDetail(id: product.id, product: product.id, quantity: 1));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product added !'),
          backgroundColor: Colors.green,
        ),
      );

      print(CartProducts);
    } else if (products.contains(product)) {
      print("Product already in cart, no action taken.");
    }
  }

  void _handleDelete(Product product) async {
    print("product deleted");
    bool response = await ProductController().deleteProduct(product);
    if (response) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product Deleted !'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error while deleting product !'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _handleUpdate(Product product) {
    print("product updated");

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => UpdateProductForm(product: product)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        onTap: () {
          _handleAddToCart(product);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: const Icon(
          Icons.add_shopping_cart_outlined,
        ),
        title: Text(
          product.name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          product.description,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          child: PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'update') {
                _handleUpdate(product);
              } else if (value == 'delete') {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Warning !"),
                      content: Text(
                          "Are you sure you want to delete this product ? ${product.name}"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            // Close the AlertDialog
                            Navigator.of(context).pop();
                          },
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            // Close the AlertDialog
                            Navigator.of(context).pop();
                            // Call the function
                            _handleDelete(product);
                          },
                          child: const Text("Delete",
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'update',
                child: Row(
                  children: [
                    Icon(Icons.edit),
                    SizedBox(width: 8.0),
                    Text('Update'),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete),
                    SizedBox(width: 8.0),
                    Text('Delete'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
