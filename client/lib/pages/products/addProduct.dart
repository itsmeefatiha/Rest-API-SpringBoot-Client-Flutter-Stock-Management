// TODO Implement this library.
import 'package:flutter/material.dart';
import 'package:stockapp/controllers/productController.dart';
import 'package:stockapp/models/productModel.dart';
import 'package:stockapp/pages/products/products.dart';

class AddProductForm extends StatefulWidget {
  const AddProductForm({super.key});

  @override
  _AddProductFormState createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _quantityController = TextEditingController();
  final refreshProducts = false;

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
          title: const Text(
            'Add Product',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: Container(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Welcome Admin! Please enter the details below to add a new product.',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 22.0),
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
                          ),
                          const SizedBox(height: 16.0),
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
                          ),
                          const SizedBox(height: 16.0),
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
                          ),
                          const SizedBox(height: 16.0),
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
                                    icon: const Icon(Icons.remove),
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
                                    icon: const Icon(Icons.add),
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
                          const SizedBox(height: 24.0),
                          SizedBox(
                            width: 450.0,
                            height: 60.0,
                            child: ElevatedButton(
                              onPressed: () {
                                _submitForm();
                              },
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(16.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  backgroundColor: Colors.white,
                                  elevation: 0.0,
                                  side: const BorderSide(
                                      width: 1.0, color: Colors.black)),
                              child: const Text(
                                'Add Product',
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
      print('Product Name: $_productName');
      print('Description: $_description');
      print('Price: $_price');
      print('Quantity: $_quantity');

      Product product = Product(
          id: null,
          name: _productName,
          description: _description,
          price: _price,
          stockQuantity: _quantity);

      Product? newProduct = await ProductController().addProduct(product);
      if (newProduct != null) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Product added !'),
            backgroundColor: Colors.green,
          ),
        );
        setState(() {
          products.add(newProduct);
          print(products);
        });
        
        // Clear the form
        _formKey.currentState!.reset();
        setState(() {
          _quantity = 0;
          _quantityController.text = '';
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error while adding product! please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
