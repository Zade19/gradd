import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:gradd/database.dart';
Future<void> requestNotificationPermission() async {
  NotificationSettings settings = await FirebaseMessaging.instance
      .requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('Notification permission granted.');
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      Back4app.installation(token);
    } else {
      print('Failed to get FCM token.');
    }
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('Provisional permission granted.');
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      Back4app.installation(token);
    }
  }
}
