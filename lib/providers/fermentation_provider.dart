import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/fermentation.dart';
import '../models/fermentation_history_item.dart';
import 'service_providers.dart';

part 'fermentation_provider.g.dart';

@Riverpod(keepAlive: true)
class ActiveFermentations extends _$ActiveFermentations {
  Timer? _timer;

  @override
  List<Fermentation> build() {
    _loadInitialData();
    ref.onDispose(() {
      _timer?.cancel();
    });
    return [];
  }

  Future<void> _loadInitialData() async {
    final service = ref.read(fermentationServiceProvider);
    final saved = await service.loadActiveFermentations();
    state = saved;
    if (state.isNotEmpty) {
      _startTimer();
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.isEmpty) {
        _timer?.cancel();
        return;
      }
      // Re-emitir estado para que la UI actualice progreso/tiempo
      state = state.map((f) => Fermentation(
        id: f.id,
        type: f.type,
        startTime: f.startTime,
        targetDuration: f.targetDuration,
        isOpenEnded: f.isOpenEnded,
        name: f.name,
      )).toList();
    });
  }

  int _stringToId(String idStr) {
    return idStr.hashCode.abs() % 100000;
  }

  Future<void> start(
    int durationSeconds, {
    FermentationType type = FermentationType.kefir,
    DateTime? customStartTime,
    bool isOpenEnded = false,
    String? name,
    required String notifReadyTitle,
    required String notifReadyBody,
    required String notifReminderTitle,
    required String notifReminderBody,
  }) async {
    final startTime = customStartTime ?? DateTime.now();
    final targetDuration = Duration(seconds: durationSeconds);

    final newFermentation = Fermentation(
      type: type,
      startTime: startTime,
      targetDuration: targetDuration,
      isOpenEnded: isOpenEnded,
      name: name?.trim().isEmpty == true ? null : name?.trim(),
    );

    final updatedState = [...state, newFermentation];

    final service = ref.read(fermentationServiceProvider);
    await service.saveActiveFermentations(updatedState);

    state = updatedState;
    if (_timer == null || !_timer!.isActive) {
      _startTimer();
    }

    // Solo programar notificación si tiene límite de tiempo definido
    if (!isOpenEnded) {
      final notifService = ref.read(notificationServiceProvider);
      final baseId = _stringToId(newFermentation.id);

      await notifService.scheduleFermentationComplete(
        baseId,
        startTime.add(targetDuration),
        notifReadyTitle,
        notifReadyBody,
        notifReminderTitle,
        notifReminderBody,
      );
    }
  }

  Future<void> stop(String id, {bool recordHistory = true, Duration? customIdealTime}) async {
    final list = state.where((f) => f.id == id).toList();
    final fermentation = list.isEmpty ? null : list.first;
    if (fermentation == null) return;

    if (recordHistory) {
      final now = DateTime.now();

      // Para fermentaciones con límite, comprobar si se completó dentro del objetivo.
      // Para sin límite, se considera siempre éxito (cosecha manual).
      final bool isSuccess = fermentation.isOpenEnded
          ? true
          : now.isAfter(
                fermentation.startTime.add(fermentation.targetDuration),
              ) ||
              now.isAtSameMomentAs(
                fermentation.startTime.add(fermentation.targetDuration),
              );

      final historyItem = FermentationHistoryItem(
        type: fermentation.type,
        startTime: fermentation.startTime,
        targetDuration: fermentation.targetDuration,
        completedAt: now,
        isSuccess: isSuccess,
        isOpenEnded: fermentation.isOpenEnded,
      );

      final service = ref.read(fermentationServiceProvider);
      await service.addHistoryEntry(historyItem);

      // Guardar el tiempo ideal: kéfir → automático, kombucha → solo si el usuario lo pide
      if (!fermentation.isOpenEnded) {
        if (customIdealTime != null &&
            fermentation.type == FermentationType.kombucha) {
          await service.saveKombuchaIdealDuration(customIdealTime);
        }
        if (fermentation.type == FermentationType.kefir) {
          await service.saveKefirIdealDuration(fermentation.targetDuration);
        }
      }
    }

    final updatedState = state.where((f) => f.id != id).toList();
    final service = ref.read(fermentationServiceProvider);
    await service.saveActiveFermentations(updatedState);

    final notifService = ref.read(notificationServiceProvider);
    await notifService.cancel(_stringToId(id));

    state = updatedState;
    if (state.isEmpty) {
      _timer?.cancel();
    }
  }

  /// Renombra una fermentación activa sin afectar el timer ni las notificaciones.
  Future<void> rename(String id, String? newName) async {
    final trimmed = newName?.trim().isEmpty == true ? null : newName?.trim();
    state = state.map((f) {
      if (f.id != id) return f;
      return Fermentation(
        id: f.id,
        type: f.type,
        startTime: f.startTime,
        targetDuration: f.targetDuration,
        isOpenEnded: f.isOpenEnded,
        name: trimmed,
      );
    }).toList();
    final service = ref.read(fermentationServiceProvider);
    await service.saveActiveFermentations(state);
  }
}
