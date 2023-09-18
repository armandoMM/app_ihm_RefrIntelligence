import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:app_ihm/Providers/db_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService = NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin notification = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  NotificationService._internal();

  Future<void> initializeApp() async {
    const AndroidInitializationSettings initSettAndr =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initSettAndr);

    final details = notification.getNotificationAppLaunchDetails();
    /*if (details != null && details.didNotificationsLaunchApp) {
      onNotifications.add(details.payload);
    }*/

    await notification.initialize(initializationSettings);
  }

  Future<void> showNotification(int id, String title, String body) async {
    await notification.show(
      id,
      title,
      body,
      const NotificationDetails(
          android: AndroidNotificationDetails(
              'main_channel', 'Main channel', 'Main channel notifications',
              importance: Importance.max, priority: Priority.max)),
    );
  }
}
