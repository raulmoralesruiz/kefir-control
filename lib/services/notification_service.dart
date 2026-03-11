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

  Future<void> scheduleFermentationComplete(DateTime scheduledDate) async {
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

    await _notificationsPlugin.zonedSchedule(
      0,
      'Fermentación Completa',
      'Tu fermentación de kéfir ha alcanzado el tiempo objetivo.',
      eventDate,
      details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> cancelAll() async {
    if (kIsWeb) return;
    await _notificationsPlugin.cancelAll();
  }
}
