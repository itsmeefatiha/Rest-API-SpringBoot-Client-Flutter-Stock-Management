import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  final _localNotificationService = FlutterLocalNotificationsPlugin();

  // Initialize the notification service
  void initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@drawable/ic_stat_android');

    final InitializationSettings settings = InitializationSettings(
      android: initializationSettingsAndroid
    );

    await _localNotificationService.initialize(
      settings,
    );
  }

  Future<NotificationDetails> _notificationsDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      'channel_id_13',
      'quantity_channel',
      channelDescription: 'description',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      icon: '@mipmap/ic_launcher', // Use the app's launcher icon as the notification icon
    );

    return NotificationDetails(
      android: androidNotificationDetails,
    );
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    final details = await _notificationsDetails();
    await _localNotificationService.show(
        id, title, body, await _notificationsDetails());
  }

  void _onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    print('Notification received: id=$id, title=$title, body=$body, payload=$payload');
  }

  void onSelectNotification(String? payload) {
    print('Notification selected: payload=$payload');
  }

}
