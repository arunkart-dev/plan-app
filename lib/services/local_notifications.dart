import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  // ---------------- INIT ----------------
  static Future<void> init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();

    const settings = InitializationSettings(
      android: android,
      iOS: ios,
    );

    await _plugin.initialize(settings);
  }

  // ---------------- EMAIL NOTIFICATION ----------------
static Future<void> sendEmailNotification({
  required String email,
  required String title,
  required String message,
}) async {
  await Supabase.instance.client.functions.invoke(
    'hyper-handler',
    body: {
      'email': email,
      'title': title,
      'message': message,
    },
  );
}


  // ---------------- INSTANT NOTIFICATION ----------------
  static Future<void> showNow({
    required int id,
    required String title,
    required String body,
  }) async {
    await _plugin.show(
      id,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'instant_channel',
          'Instant Notifications',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
    );
  }

  // ---------------- ONE-TIME SCHEDULED ----------------
  static Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required DateTime time,
  }) async {
    await _plugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(time, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'reminders',
          'Task Reminders',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  // ---------------- HOURLY REMINDER ----------------
  static Future<void> startHourlyReminder() async {
    await _plugin.periodicallyShow(
      999, // fixed id → only one hourly reminder
      'Stay Focused 💪',
      'Don’t forget to work on your plans!',
      RepeatInterval.hourly,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'hourly_channel',
          'Hourly Reminders',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
    );
  }

  // ---------------- STOP HOURLY REMINDER ----------------
  static Future<void> stopHourlyReminder() async {
    await _plugin.cancel(999);
  }

  // ---------------- CANCEL ALL (OPTIONAL) ----------------
  static Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }
}
