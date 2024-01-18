import 'package:flutter/material.dart';
import 'package:stockapp/controllers/clientController.dart';
import 'package:stockapp/models/clientModel.dart';

class UpdateClientForm extends StatefulWidget {
  final ClientModel client;

  UpdateClientForm({required this.client});

  @override
  _UpdateClientFormState createState() => _UpdateClientFormState();
}

class _UpdateClientFormState extends State<UpdateClientForm> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController phoneNumberController;
  late TextEditingController addressController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing client data
    firstNameController = TextEditingController(text: widget.client.first_name);
    lastNameController = TextEditingController(text: widget.client.last_name);
    phoneNumberController =
        TextEditingController(text: widget.client.phone_number);
    addressController = TextEditingController(text: widget.client.adress);
    emailController = TextEditingController(text: widget.client.email);
  }

  @override
  void dispose() {
    // Dispose controllers when the widget is disposed
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Client'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Update Client Information',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                width: 450.0,
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        controller: firstNameController,
                        decoration: InputDecoration(
                          labelText: 'First Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: lastNameController,
                        decoration: InputDecoration(
                          labelText: 'Last Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: phoneNumberController,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: addressController,
                        decoration: InputDecoration(
                          labelText: 'Address',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      SizedBox(
                        width: 450.0,
                        height: 60.0,
                        child: ElevatedButton(
                          onPressed: () {
                            _updateClient();
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: const BorderSide(color: Colors.black),
                            ),
                            primary: Colors.white,
                          ),
                          child: const Text(
                            'Save',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                            ),
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
    );
  }

  void _updateClient() async {
    ClientModel updatedClient = ClientModel(
        id: widget.client.id,
        first_name: firstNameController.text,
        last_name: lastNameController.text,
        phone_number: phoneNumberController.text,
        adress: addressController.text,
        email: emailController.text);

    bool response =
        await ClientController().updateClient(updatedClient);
    if (response == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Client Updated',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Client Not Updated',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
