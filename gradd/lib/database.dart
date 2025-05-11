import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class Back4app
{
  static const String _baseUrl = "https://parseapi.back4app.com/classes/";

  static Future<void> initializeParse() async //connect to our parse server running on back4app
  {
    const String appId = 'vsygoeJ7t6A7DRNxCqPeWPit94y3YNHmh5VhllOl';
    const String clientKey = 'j0fnJLJnzRc99kydpLLa0INg59NX6aEEhCyFtz2N';
    const String serverUrl = 'https://parseapi.back4app.com';
    await Parse().initialize(
        appId, serverUrl, clientKey: clientKey, autoSendSessionId: true);
  }
  static Future<void> installation(String token) async//create an installation object for this device and adn join the group all
  {
    final installation = await ParseInstallation.currentInstallation();
    installation.set<String>('deviceToken', token);
    installation.subscribeToChannel('all');
    var response =  await installation.save();
    if (response.success) {
      print('Installation saved!');
    } else {
      print('Failed to save installation: ${response.error?.message}');
    }
  }
}