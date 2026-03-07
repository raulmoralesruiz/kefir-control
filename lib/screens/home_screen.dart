import 'dart:async';
import 'package:flutter/material.dart';
import '../models/fermentation.dart';
import '../services/fermentation_service.dart';
import '../services/notification_service.dart';
import '../widgets/start_fermentation_buttons.dart';
import '../widgets/stop_fermentation_button.dart';
import '../widgets/manual_start_dialog.dart';
import '../widgets/time_progress.dart';
import 'info_screen.dart';

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

  Future<void> _showStartDialog({required bool askForDate}) async {
    final result =
        await ManualStartDialog.show(context, askForDate: askForDate);
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

  Widget _buildActionButtons() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (_fermentation == null || _fermentation!.progress >= 1.0)
          StartFermentationButtons(
            onStartNow: () => _showStartDialog(askForDate: false),
            onStartPast: () => _showStartDialog(askForDate: true),
          ),
        const SizedBox(height: 16),
        if (_fermentation != null)
          StopFermentationButton(
            onStop: _stopFermentation,
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kéfir Control'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'Información y Guía',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const InfoScreen()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: _fermentation == null
            ? Column(
                children: [
                  const Expanded(
                    child: Center(
                      child: Text(
                        'No hay fermentación activa.',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildActionButtons(),
                  ),
                ],
              )
            : TimeProgress(
                fermentation: _fermentation!,
                actionButtons: _buildActionButtons(),
              ),
      ),
    );
  }
}
