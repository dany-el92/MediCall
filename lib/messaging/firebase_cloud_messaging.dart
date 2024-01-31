import 'package:firebase_messaging/firebase_messaging.dart';

class CloudMessaging {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    print('Token: ${await _firebaseMessaging.getToken()}');
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
