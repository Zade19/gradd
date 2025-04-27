import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class Back4app{
  static const String _baseUrl = "https://parseapi.back4app.com/classes/";

  static Future<void> initializeParse() async
  {
    //FirebaseMessaging messaging = FirebaseMessaging.instance;
    //String? token = await messaging.getToken();
    const String appId = 'vsygoeJ7t6A7DRNxCqPeWPit94y3YNHmh5VhllOl';
    const String clientKey = 'j0fnJLJnzRc99kydpLLa0INg59NX6aEEhCyFtz2N';
    const String serverUrl = 'https://parseapi.back4app.com';
    await Parse().initialize(appId, serverUrl, clientKey: clientKey, autoSendSessionId: true);
    //await Firebase.initializeApp();
    final installation = await ParseInstallation.currentInstallation();
    installation.subscribeToChannel('all');
    var response =  await installation.save();
    if (response.success) {
      print('Installation saved!');
    } else {
      print('Failed to save installation: ${response.error?.message}');
    }
  }

}