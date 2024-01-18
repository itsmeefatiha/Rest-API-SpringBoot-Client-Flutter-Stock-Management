import 'package:flutter/material.dart';
import 'package:stockapp/controllers/clientController.dart';
import 'package:stockapp/models/clientModel.dart';
import 'updateClientForm.dart';

List<ClientModel> clients = [];

class ClientList extends StatefulWidget {
  const ClientList({super.key});

  @override
  State<ClientList> createState() => _ClientListState();
}

class _ClientListState extends State<ClientList> {
  @override
  void initState() {
    super.initState();
    _loadClients();
  }

  Future<void> _loadClients() async {
    try {
      // Perform asynchronous operation outside of setState
      List<ClientModel> loadedClients = await ClientController().getClients();

      // Update the state inside setState
      setState(() {
        clients = loadedClients;
      });
    } catch (e) {
      print("Error while loading clients: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    _loadClients();
    return Scaffold(
      appBar: AppBar(
        title: Text('Clients List'),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: clients.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                title: Text(
                  '${clients[index].first_name} ${clients[index].last_name}',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Icon(Icons.phone, size: 16.0),
                        SizedBox(width: 4.0),
                        Text('${clients[index].phone_number}',
                            style: TextStyle(fontSize: 16.0)),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 16.0),
                        SizedBox(width: 4.0),
                        Text('${clients[index].adress}',
                            style: TextStyle(fontSize: 16.0)),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Icon(Icons.email, size: 16.0),
                        SizedBox(width: 4.0),
                        Text('${clients[index].email}',
                            style: TextStyle(fontSize: 16.0)),
                      ],
                    ),
                    SizedBox(height: 8.0),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.grey),
                      onPressed: () {
                        // Handle edit button press
                        _navigateToUpdateClientForm(context, clients[index]);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.grey),
                      onPressed: () {
                        // Handle delete button press
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Warning !"),
                              content: Text(
                                  "Are you sure you want to delete this client ? ${clients[index].first_name}"),
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
                                    _handleDelete(clients[index]);
                                  },
                                  child: const Text(
                                    "Delete",
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _handleDelete(ClientModel client) async {
    print("product deleted");
    bool response = await ClientController().deleteClient(client);
    print(response);
    if (response == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Client Deleted !'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error while deleting client !'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _navigateToUpdateClientForm(BuildContext context, ClientModel client) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateClientForm(client: client),
      ),
    );
  }
}
