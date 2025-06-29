import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  // initialize
  Future<void> initNotification() async {
    if (_isInitialized) return;

    const AndroidInitializationSettings initSettingsAndroid =
        AndroidInitializationSettings(
          '@mipmap/ic_launcher',
        ); // default app icon

    const initSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initSettings = InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingsIOS,
    );

    await _notificationsPlugin.initialize(initSettings);
  }

  // notifications detail setup
  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'default_channel', // channel id
        'General', // channel name
        channelDescription: 'General notifications',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  // show notification
  // Future<void> showNotification({
  //   required int id,
  //   String? title,
  //   String? body,
  // }) async {
  //   return await _notificationsPlugin.show(
  //     id,
  //     title,
  //     body,
  //     notificationDetails(),
  //   );
  // }

  // schedule a notification
  Future<void> scheduleNotification({
    int id = 1,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    final now = tz.TZDateTime.now(tz.local);

    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    await _notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      notificationDetails(),

      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,

      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  /// Schedules notifications for a specific date, starting from a given time,
  /// with a custom interval (in hours or minutes) between each notification.
  ///
  /// [date]: The date for which to schedule notifications (year, month, day are used).
  /// [intervalHours]: The interval in hours between notifications (default: 5).
  /// [intervalMinutes]: The interval in minutes between notifications (optional, for testing).
  /// [count]: How many notifications to schedule (default: 5).
  /// [startHour]: The hour to start scheduling (default: 0).
  /// [startMinute]: The minute to start scheduling (default: 0).
  /// [title]: The notification title.
  /// [body]: The notification body.
  Future<void> scheduleNotificationsForDate({
    required DateTime date,
    int intervalHours = 5, // Change this to adjust the interval (hours)
    int? intervalMinutes, // Set this for minute-based intervals (for testing)
    int count = 5, // Change this to adjust how many notifications
    int startHour = 0, // Change this to adjust the starting hour
    int startMinute = 0, // Change this to adjust the starting minute
    String title = 'Reminder', // Change this for notification title
    String body =
        'This is your scheduled notification!', // Change this for notification body
  }) async {
    // Loop to schedule notifications at each interval
    for (int i = 0; i < count; i++) {
      int hour = startHour;
      int minute = startMinute;
      if (intervalMinutes != null) {
        // For minute-based intervals (testing)
        int totalMinutes = startHour * 60 + startMinute + (i * intervalMinutes);
        hour = totalMinutes ~/ 60;
        minute = totalMinutes % 60;
      } else {
        // For hour-based intervals (default)
        hour = startHour + (i * intervalHours);
      }
      final scheduledDate = tz.TZDateTime(
        tz.local,
        date.year,
        date.month,
        date.day,
        hour,
        minute,
      );
      // Each notification gets a unique id (e.g., 100, 101, 102...)
      await _notificationsPlugin.zonedSchedule(
        100 + i, // Change 100 to any base id you want
        title,
        body,
        scheduledDate,
        notificationDetails(),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.dateAndTime,
      );
    }
  }
}
