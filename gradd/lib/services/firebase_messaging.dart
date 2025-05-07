import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:gradd/database.dart';
Future<void> requestNotificationPermission() async {
  // Request notification permission
  NotificationSettings settings = await FirebaseMessaging.instance
      .requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  // Check the authorization status
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('Notification permission granted.');
    // After permission is granted, get the FCM token and device info and save it into the database
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      Back4app.installation(token);
    } else {
      print('Failed to get FCM token.');
    }
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('Provisional permission granted.');
    // After provisional permission, get the FCM token
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      Back4app.installation(token);
    }
  }
}
