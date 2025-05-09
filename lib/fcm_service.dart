import 'package:firebase_messaging/firebase_messaging.dart';

class FcmService {
  Future<void> init() async {
    await FirebaseMessaging.instance.requestPermission();

    FirebaseMessaging.instance.getInitialMessage();

    //foreground state
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      //send local notification
      _handleNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotification);

    //background state
    FirebaseMessaging.onBackgroundMessage(_handleBackgroundNotification);
  }

  Future<void> _handleBackgroundNotification(RemoteMessage message) async {
    //have to call an API/save to local db
  }
  void _handleNotification(RemoteMessage message) {
    String formattedMessage = '''
    Title:${message.notification?.title}
    Body: ${message.notification?.body}
    Data: ${message.data}
    ''';
    print(formattedMessage);
  }

  Future<String?> getFcmToken() async {
    //Have to send to the DB via login api
    return await FirebaseMessaging.instance.getToken();
  }

  void onTokenRefresh() {
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      //send to db via API
    });
  }
}
