import 'package:flutter/material.dart';
import 'package:http/src/response.dart';
import 'package:stockapp/controllers/authentification.dart';
import 'package:stockapp/pages/products/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // SizedBox(height: 50),
            // Icon(
            //   Icons.lock,
            //   size: 80,
            // ),
            // SizedBox(height: 15),
            Text(
              "Sign In",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 25),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                  labelText: "Password", border: OutlineInputBorder()),
              obscureText: true,
            ),
            SizedBox(height: 20),
            Container(
                width: double.infinity,
                color: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: OutlinedButton.icon(
                      onPressed: () async {
                        String email = _emailController.text;
                        String password = _passwordController.text;
                        int response = await authenticate(email, password, context);
                        if (response == 1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Email or password incorrect !'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      icon: const Icon(
                        Icons.lock_open,
                        color: Colors.black,
                      ),
                      label: const Text(
                        'Sign In',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      )),
                )),
          ],
        ),
      ),
    );
  }
}
