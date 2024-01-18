import 'package:flutter/material.dart';
import 'package:stockapp/controllers/productController.dart';
import 'package:stockapp/models/productModel.dart';
import 'package:stockapp/widgets/products_list.dart';

import '../../utils/NotificationService.dart';

List<Product> products = [];

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});
  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final NotificationService notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    _loadProduct();
  }

  Future<void> _loadProduct() async {
    try {
      // Perform asynchronous work outside of setState
      List<Product> loadedProducts = await ProductController().getProducts();

      // Update the state synchronously inside setState
      setState(() {
        products = loadedProducts;
      });
    } catch (e) {
      print("Error while loading products. Error msg: $e");
    }
  }

  void addNewProduct(Product product) {
    setState(() {
      if (!products.contains(product)) {
        products.add(product);
      }
    });
  }

  void deleteProduct(Product product) {
    setState(() {
      if (products.contains(product)) {
        products.remove(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _loadProduct();
    return Stack(children: [
      Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            children: [
              // SearchBox(),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 50, bottom: 20),
                      child: const Text(
                        'All Products',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    for (Product pr in products)
                      ProductsList(
                        product: pr,
                        context: context,
                      )
                  ],
                ),
              )
            ],
          ))
    ]);
  }
}
