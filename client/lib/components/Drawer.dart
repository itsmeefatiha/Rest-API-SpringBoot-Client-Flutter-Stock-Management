// // ignore_for_file: file_names

// import 'package:flutter/material.dart';
// import 'package:stockapp/main.dart';
// import 'package:stockapp/pages/auth/login.dart';
// import 'package:stockapp/pages/products/addProduct.dart';
import 'package:flutter/material.dart';
import 'package:stockapp/main.dart';
import 'package:stockapp/pages/auth/login.dart';
import 'package:stockapp/pages/client/addClientForm.dart';
import 'package:stockapp/pages/client/clientsList.dart';
import 'package:stockapp/pages/products/addProduct.dart';


import '../controllers/notificationController.dart';

class NavBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('oflutter.com'),
            accountEmail: Text('example@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                image: NetworkImage(
                  'https://oflutter.com/wp-content/uploads/2021/02/profile-bo3.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text("add product"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddProductForm(),
              ));
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text("Clients List"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ClientList(),
              ));
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text("Add Client"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddClientForm(),
              ));
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('notification'),
            onTap: () {

            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Logout"),
            onTap: () {
              AuthState().isAuthenticated = false;

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

Future<void> showNotification() async {

}
