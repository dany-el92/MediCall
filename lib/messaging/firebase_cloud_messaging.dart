import 'dart:developer';
import 'package:medicall/utilities/api_services.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medicall/main.dart';

class CloudMessaging {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.',
    // description
    importance: Importance.defaultImportance,
  );
  final _localNotifications = FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();

    String? token = await _firebaseMessaging.getToken();

    if (token != null) {
      try {
        var response = await http.post(
          Uri.parse('http://89.168.86.207:5001/save_token'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({'token': token}),
        );

        if (response.statusCode == 200) {
          print('Token sent to the server successfully');
        } else {
          print('Failed to send token to the server');
        }
      } catch (e) {
        print('Failed to send token to the server. Error: $e');
      }
    } else {
      print('Failed to get FCM token');
    }

    initPushNotification();
    initLocalNotification();
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    // All'apertura della notifica rimando alla pagina delle prenotazioni (calendar_view)
    CurvedNavigationBarState? state = bottomNavigationKey.currentState;
    state?.setPage(1);
  }

  Future initLocalNotification() async {
    const iOS = DarwinInitializationSettings();
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const settings = InitializationSettings(android: android, iOS: iOS);

    await _localNotifications.initialize(settings,
        onDidReceiveNotificationResponse: (payload) {
      final message = RemoteMessage.fromMap(jsonDecode(payload.payload!));
      handleMessage(message);
    });

    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()!;
    await platform.createNotificationChannel(_androidChannel);
  }

  Future initPushNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;

      if (notification.title == "Prenotazione effettuata") {
        // TODO: crea appuntamento nel calendario
      } else if (notification.title == "Prenotazione rifiutata") {
        // TODO: fai qualcosa
        APIServices.deleteLatestAppointment();
      }

      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: '@drawable/ic_launcher',
          ),
        ),
        payload: jsonEncode(message.toMap()),
      );
    });
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  final notification = message.notification;
  if (notification == null) return;

  if (notification.title == "Prenotazione effettuata") {
    // TODO: crea appuntamento nel calendario
  } else if (notification.title == "Prenotazione rifiutata") {
    // TODO: fai qualcosa
    APIServices.deleteLatestAppointment();
  }
}
