import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool _isInit = false;

  Future<void> init() async {
    if (kIsWeb) {
      return; // Las notificaciones locales nativas no funcionan en web base
    }
    if (_isInit) return;

    tz.initializeTimeZones();
    final tzInfo = await FlutterTimezone.getLocalTimezone();
    final String timeZoneName = tzInfo.identifier;
    tz.setLocalLocation(tz.getLocation(timeZoneName));

    const androidSettings = AndroidInitializationSettings('ic_stat_kefir');
    const darwinSettings = DarwinInitializationSettings();
    const initSettings =
        InitializationSettings(android: androidSettings, iOS: darwinSettings);
    await _notificationsPlugin.initialize(initSettings);

    final androidPlugin =
        _notificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    if (androidPlugin != null) {
      await androidPlugin.requestNotificationsPermission();
    }

    _isInit = true;
  }

  Future<void> scheduleFermentationComplete(
      DateTime scheduledDate,
      String titleReady,
      String bodyReady,
      String titleReminder,
      String bodyReminder) async {
    await init();
    if (kIsWeb) return; // No intentamos programar en web

    const androidDetails = AndroidNotificationDetails(
      'kefir_control_channel',
      'Kefir Control',
      channelDescription:
          'Notificaciones de finalización de fermentación de kéfir',
      importance: Importance.max,
      priority: Priority.high,
    );
    const iosDetails = DarwinNotificationDetails();
    const details =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    final eventDate = tz.TZDateTime.from(scheduledDate, tz.local);
    final now = tz.TZDateTime.now(tz.local);

    // Ignore if time is already in the past
    if (eventDate.isBefore(now)) return;

    // Schedule the 2 hours reminder if it's not in the past
    final reminderDate = eventDate.subtract(const Duration(hours: 2));
    if (reminderDate.isAfter(now)) {
      await _notificationsPlugin.zonedSchedule(
        1,
        titleReminder,
        bodyReminder,
        reminderDate,
        details,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }

    await _notificationsPlugin.zonedSchedule(
      0,
      titleReady,
      bodyReady,
      eventDate,
      details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> cancelAll() async {
    await init();
    if (kIsWeb) return;
    await _notificationsPlugin.cancelAll();
  }
}
