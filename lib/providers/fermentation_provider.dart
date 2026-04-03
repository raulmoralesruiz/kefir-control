import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/fermentation.dart';
import '../models/fermentation_history_item.dart';
import 'service_providers.dart';

part 'fermentation_provider.g.dart';

@Riverpod(keepAlive: true)
class ActiveFermentation extends _$ActiveFermentation {
  Timer? _timer;

  @override
  Fermentation? build() {
    _loadInitialData();
    ref.onDispose(() {
      _timer?.cancel();
    });
    return null;
  }

  Future<void> _loadInitialData() async {
    final service = ref.read(fermentationServiceProvider);
    final saved = await service.loadFermentation();
    if (saved != null) {
      state = saved;
      _startTimer();
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // Re-emit state to trigger UI updates for progress/time
      if (state != null) {
        state = Fermentation(
          startTime: state!.startTime,
          targetDuration: state!.targetDuration,
        );
        if (state!.progress >= 1.0) {
          _timer?.cancel();
        }
      }
    });
  }

  Future<void> start(
    int hours, {
    DateTime? customStartTime,
    required String notifReadyTitle,
    required String notifReadyBody,
    required String notifReminderTitle,
    required String notifReminderBody,
  }) async {
    final startTime = customStartTime ?? DateTime.now();
    final targetDuration = Duration(hours: hours);
    final newFermentation = Fermentation(
      startTime: startTime,
      targetDuration: targetDuration,
    );

    final service = ref.read(fermentationServiceProvider);
    await service.saveFermentation(newFermentation);
    
    state = newFermentation;
    _startTimer();

    // Notificaciones
    final notifService = ref.read(notificationServiceProvider);
    await notifService.cancelAll();
    await notifService.scheduleFermentationComplete(
      startTime.add(targetDuration),
      notifReadyTitle,
      notifReadyBody,
      notifReminderTitle,
      notifReminderBody,
    );
  }

  Future<void> stop() async {
    if (state != null) {
      final now = DateTime.now();
      final isSuccess = now.isAfter(state!.startTime.add(state!.targetDuration)) ||
          now.isAtSameMomentAs(state!.startTime.add(state!.targetDuration));
      
      final historyItem = FermentationHistoryItem(
        startTime: state!.startTime,
        targetDuration: state!.targetDuration,
        completedAt: now,
        isSuccess: isSuccess,
      );
      
      final service = ref.read(fermentationServiceProvider);
      await service.addHistoryEntry(historyItem);
    }

    final service = ref.read(fermentationServiceProvider);
    await service.clearFermentation();
    _timer?.cancel();
    
    final notifService = ref.read(notificationServiceProvider);
    await notifService.cancelAll();

    state = null;
  }
}
