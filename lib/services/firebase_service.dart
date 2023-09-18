//SHA-1: 2E:4D:0A:33:38:C9:AC:8F:C1:E8:A1:A1:61:EE:4A:7C:F3:E4:A5:4F

import 'package:app_ihm/Providers/db_provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationService {
  //static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static final PushNotificationService _notificationService = PushNotificationService._internal();
  static String? token;

  factory PushNotificationService() {
    return _notificationService;
  }

  /*static Future _backgroundHandler(RemoteMessage m) async {
    print('onbackground Handler${m.messageId}');
  }

  static Future _onMessageHandler(RemoteMessage m) async {
    print('onMessage Handler${m.messageId}');
  }

  static Future _MessageOpenAppHandler(RemoteMessage m) async {
    print('onMessageOpenApp Handler${m.messageId}');
  }*/

  final FlutterLocalNotificationsPlugin notification = FlutterLocalNotificationsPlugin();

  PushNotificationService._internal();

  static Future initializeApp() async {
    //Local notification
    final historics = await DBProvider.db.getUltimateHistoricos();
    print(historics.map((e) => e.fechaCaducidad).toString());

    //Push notification
    /*await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print(token);

    //Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_MessageOpenAppHandler);*/
  }
}
