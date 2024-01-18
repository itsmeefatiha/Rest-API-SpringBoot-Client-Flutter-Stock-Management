import 'package:flutter/material.dart';
import 'package:stockapp/components/AppBar.dart';
import 'package:stockapp/components/Drawer.dart';
import 'package:stockapp/pages/products/products.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:stockapp/utils/NotificationService.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late IO.Socket socket;
  final NotificationService notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    initSocket();
  }

  void initSocket() {
    print("Initializing socket...");

    socket = IO.io('http://192.168.1.174:9091', <String, dynamic>{
      'autoConnect': true,
      'transports': ['websocket'],
    });

    socket.on('connect', (_) {
      print('Connected to server');
    });

    socket.on('disconnect', (_) {
      print('Disconnected from server');
    });

    socket.on('error', (error) {
      print('Socket error: $error');
    });

    socket.on('notify', (data) {
      print('Notification received: $data');

      if (data is List<dynamic>) {
        for (var item in data) {
          if (item is String) {
            showNotification(item);
          }
        }
      } else if (data is String) {
        showNotification(data);
      }
    });

    socket.connect();

    print("Socket initialized successfully.");
  }

  void showNotification(String productName) {
    notificationService.showNotification(
      id: 1,
      title: productName,
      body: 'Low stock for product: $productName',
    );
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      drawer: NavBar(),
      body: Scaffold(
        backgroundColor: Colors.white,
        body: ProductPage(),
      ),
    );
  }
}
