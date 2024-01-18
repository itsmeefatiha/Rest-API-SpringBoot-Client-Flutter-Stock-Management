// TODO Implement this library.
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stockapp/controllers/productController.dart';
import 'package:stockapp/models/productModel.dart';

class UpdateProductForm extends StatefulWidget {
  final Product product;

  UpdateProductForm({required this.product});

  @override
  _UpdateProductFormState createState() => _UpdateProductFormState();
}

class _UpdateProductFormState extends State<UpdateProductForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _quantityController = TextEditingController();

  // Form fields
  late String _initialproductName;
  late double _initialPrice;
  late String _initialDescription;
  late int _initialQuantity;
  late int _productId;

  @override
  void initState() {
    super.initState();
    // Initialize form fields with the values from the provided product
    _initialproductName = widget.product.name;
    _initialPrice = widget.product.price;
    _initialDescription = widget.product.description; // Assuming you have a 'description' field in your Product class
    _initialQuantity = widget.product.stockQuantity;
    _productId = widget.product.id!;
    _quantityController.text = _initialQuantity.toString();
  }

  // Form fields
  String _productName = '';
  double _price = 0.0;
  String _description = '';
  int _quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Update Product',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: Container(
          padding: EdgeInsets.all(15.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Welcome Admin! Please enter the details below to Update a new product.',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.0),
                  SizedBox(
                    width: 450.0,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Product Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'Product Name is required';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _productName = value!;
                            },
                            initialValue: _initialproductName,
                          ),
                          SizedBox(height: 16.0),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Description',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'Description is required';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _description = value!;
                            },
                            initialValue: _initialDescription,
                          ),
                          SizedBox(height: 16.0),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Price',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'Price is required';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _price = double.parse(value!);
                            },
                            initialValue: _initialPrice.toString(),
                          ),
                          SizedBox(height: 16.0),
                          TextFormField(
                            controller: _quantityController,
                            decoration: InputDecoration(
                              labelText: 'Quantity',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              suffixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove),
                                    onPressed: () {
                                      setState(() {
                                        _quantity =
                                            (_quantity > 0) ? _quantity - 1 : 0;
                                        _quantityController.text =
                                            _quantity.toString();
                                      });
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.update),
                                    onPressed: () {
                                      setState(() {
                                        _quantity++;
                                        _quantityController.text =
                                            _quantity.toString();
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'Quantity is required';
                              }
                              if (int.tryParse(value) == null) {
                                return 'Please enter a valid number';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _quantity = int.parse(value!);
                            },
                          ),
                          SizedBox(height: 24.0),
                          SizedBox(
                            width: 450.0,
                            height: 60.0,
                            child: ElevatedButton(
                              onPressed: () {
                                _submitForm();
                              },
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(16.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  backgroundColor: Colors.white,
                                  elevation: 0.0,
                                  side: const BorderSide(
                                      width: 1.0, color: Colors.black)),
                              child: Text(
                                'Update Product',
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Perform actions with the form data (e.g., save to the database)
      print('Product Id: $_productId');
      print('Product Name: $_productName');
      print('Description: $_description');
      print('Price: $_price');
      print('Quantity: $_quantity');

      Product updatedProduct = Product(
          id: _productId,
          name: _productName,
          description: _description,
          price: _price,
          stockQuantity: _quantity);

      bool response = await ProductController().UpdateProduct(updatedProduct) as bool;
      if (response == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Product updateed !'),
            backgroundColor: Colors.green,
          ),
        );

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error while update product! please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}