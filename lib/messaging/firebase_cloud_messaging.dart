import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CloudMessaging {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();

    String? token = await _firebaseMessaging.getToken();

    if (token != null) {
      var response = await http.post(
        Uri.parse('http://89.168.86.207:5001/save_token'),
        // Replace with your server URL
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'token': token}),
      );

      if (response.statusCode == 200) {
        print('Token sent to the server successfully');
      } else {
        print('Failed to send token to the server');
      }
    } else {
      print('Failed to get FCM token');
    }

    initPushNotification();
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    print(
        '${message.notification!.title} ${message.notification!.body} ${message.data}');
  }

  Future initPushNotification() async {
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onMessage.listen(handleMessage);
  }
}
