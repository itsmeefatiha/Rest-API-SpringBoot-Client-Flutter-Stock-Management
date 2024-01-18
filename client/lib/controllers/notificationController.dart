import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stockapp/utils/constants.dart';

Future<void> sendNotification(String message) async {
  final response = await http.post(
    Uri.http(Constants.baseUrl, '/send-notification'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'message': message}),
  );

  if (response.statusCode == 200) {
    print('Notification sent successfully');
  } else {
    print('Failed to send notification. Status code: ${response.statusCode}');
  }
}
