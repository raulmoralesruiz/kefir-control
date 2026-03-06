import 'dart:async';
import 'package:flutter/material.dart';
import '../models/fermentation.dart';
import '../services/fermentation_service.dart';
import '../services/notification_service.dart';
import '../widgets/quick_start_buttons.dart';
import '../widgets/manual_start_dialog.dart';
import '../widgets/time_progress.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FermentationService _service = FermentationService();
  final NotificationService _notificationService = NotificationService();

  Fermentation? _fermentation;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _initNotifications();
    _loadData();
  }

  Future<void> _initNotifications() async {
    await _notificationService.init();
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
    await _notificationService.cancelAll();
    await _notificationService
        .scheduleFermentationComplete(startTime.add(targetDuration));
  }

  Future<void> _showManualStartDialog() async {
    final result = await ManualStartDialog.show(context);
    if (result != null) {
      _startFermentation(result.hours, customStartTime: result.customStartTime);
    }
  }

  void _stopFermentation() async {
    await _service.clearFermentation();
    _timer?.cancel();
    await _notificationService.cancelAll();
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
                  QuickStartButtons(
                    onStartFermentation: _startFermentation,
                    onManualStart: _showManualStartDialog,
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
                      _notificationService.scheduleFermentationComplete(
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
