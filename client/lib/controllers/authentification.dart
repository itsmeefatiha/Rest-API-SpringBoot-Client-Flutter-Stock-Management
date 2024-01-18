import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:stockapp/main.dart';
import 'package:stockapp/utils/constants.dart';

Future<int> authenticate(
    String email, String password, BuildContext context) async {
  try {
    var response = await http.post(
      Uri.http(Constants.baseUrl, Constants.authApi),
      headers: {'Content-Type': 'application/json', 'Accept': '*/*'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      Provider.of<AuthState>(context, listen: false).isAuthenticated = true;
      return 1;
    }
  } catch (err) {
    print("Auth Error : $err");
  }

  return 0;
}
