import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../models/fermentation.dart';
import '../services/fermentation_service.dart';
import '../widgets/time_progress.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FermentationService _service = FermentationService();
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Fermentation? _fermentation;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _initNotifications();
    _loadData();
  }

  Future<void> _initNotifications() async {
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
  }

  Future<void> _loadData() async {
    final saved = await _service.loadFermentation();
    if (saved != null) {
      setState(() {
        _fermentation = saved;
      });
      _startTimer();
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
      if (_fermentation != null && _fermentation!.progress >= 1.0) {
        _timer?.cancel();
      }
    });
  }

  Future<void> _scheduleNotification(DateTime scheduledDate) async {
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

  void _startFermentation(int hours, {DateTime? customStartTime}) async {
    final startTime = customStartTime ?? DateTime.now();
    final targetDuration = Duration(hours: hours);
    final newFermentation = Fermentation(
      startTime: startTime,
      targetDuration: targetDuration,
    );
    await _service.saveFermentation(newFermentation);
    setState(() {
      _fermentation = newFermentation;
    });
    _startTimer();

    // Cancela cualquier notificación anterior y programa la nueva
    await _notificationsPlugin.cancelAll();
    await _scheduleNotification(startTime.add(targetDuration));
  }

  Future<void> _showManualStartDialog() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 7)),
      lastDate: DateTime.now(),
    );
    if (date == null) return;

    if (!mounted) return;
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time == null) return;

    final customDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    int selectedHours = 24;

    if (!mounted) return;

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Selecciona la duración'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile<int>(
                    title: const Text('24 horas'),
                    value: 24,
                    groupValue: selectedHours,
                    onChanged: (val) => setState(() => selectedHours = val!),
                  ),
                  RadioListTile<int>(
                    title: const Text('36 horas'),
                    value: 36,
                    groupValue: selectedHours,
                    onChanged: (val) => setState(() => selectedHours = val!),
                  ),
                  RadioListTile<int>(
                    title: const Text('48 horas'),
                    value: 48,
                    groupValue: selectedHours,
                    onChanged: (val) => setState(() => selectedHours = val!),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _startFermentation(selectedHours,
                        customStartTime: customDateTime);
                  },
                  child: const Text('Iniciar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _stopFermentation() async {
    await _service.clearFermentation();
    _timer?.cancel();
    await _notificationsPlugin.cancelAll();
    setState(() {
      _fermentation = null;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kéfir Control'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _fermentation == null
                  ? const Center(
                      child: Text(
                        'No hay fermentación activa.',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : TimeProgress(fermentation: _fermentation!),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () => _startFermentation(24),
                        child: const Text('24h'),
                      ),
                      ElevatedButton(
                        onPressed: () => _startFermentation(36),
                        child: const Text('36h'),
                      ),
                      ElevatedButton(
                        onPressed: () => _startFermentation(48),
                        child: const Text('48h'),
                      ),
                      IconButton(
                        onPressed: _showManualStartDialog,
                        icon: const Icon(Icons.edit_calendar),
                        tooltip: 'Inicio Manual',
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (_fermentation != null)
                    TextButton.icon(
                      onPressed: _stopFermentation,
                      icon: const Icon(Icons.stop_circle, color: Colors.red),
                      label: const Text('Finalizar fermentación',
                          style: TextStyle(color: Colors.red)),
                    ),
                  const SizedBox(height: 16),
                  TextButton.icon(
                    onPressed: () {
                      _scheduleNotification(
                          DateTime.now().add(const Duration(seconds: 10)));
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              'Notificación programada en 10 segundos. ¡Minimiza la app!')));
                    },
                    icon: const Icon(Icons.science, color: Colors.grey),
                    label: const Text('Probar Notificación en 10s',
                        style: TextStyle(color: Colors.grey)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
