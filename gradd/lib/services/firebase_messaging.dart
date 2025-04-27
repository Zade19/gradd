import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> requestNotificationPermission() async {
  // Request notification permission
  NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  // Check the authorization status
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('Notification permission granted.');
    // After permission is granted, get the FCM token
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      print('FCM Token: $token');
    } else {
      print('Failed to get FCM token.');
    }
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('Provisional permission granted.');
    // After provisional permission, get the FCM token
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      print('FCM Token: $token');
    } else {
      print('Failed to get FCM token.');
    }
  } else {
    print('Notification permission declined.');
  }
}

