import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/fermentation.dart';
import '../models/fermentation_history_item.dart';

class FermentationService {
  static const String _activeListKey = 'fermentation_active_list';
  static const String _historyKey = 'fermentation_history';
  static const String _kombuchaIdealTimeKey = 'kombucha_ideal_duration_seconds';
  static const String _kefirIdealTimeKey = 'kefir_ideal_duration_seconds';

  // --- Fermentaciones activas ---

  Future<void> saveActiveFermentations(List<Fermentation> fermentations) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = fermentations.map((f) => f.toJson()).toList();
    await prefs.setString(_activeListKey, jsonEncode(jsonList));
  }

  Future<List<Fermentation>> loadActiveFermentations() async {
    final prefs = await SharedPreferences.getInstance();

    // Limpiar datos del tracker antiguo (clave única) si existen.
    await prefs.remove('fermentation_start_time');
    await prefs.remove('fermentation_duration_hours');

    final String? jsonString = prefs.getString(_activeListKey);
    if (jsonString == null) return [];

    try {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList
          .map((item) => Fermentation.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  // --- Tiempo ideal de Kombucha ---

  Future<void> saveKombuchaIdealDuration(Duration duration) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kombuchaIdealTimeKey, duration.inSeconds);
  }

  Future<Duration?> getKombuchaIdealDuration() async {
    final prefs = await SharedPreferences.getInstance();
    final seconds = prefs.getInt(_kombuchaIdealTimeKey);
    if (seconds != null) {
      return Duration(seconds: seconds);
    }
    return null;
  }

  // --- Tiempo ideal de Kéfir ---

  Future<void> saveKefirIdealDuration(Duration duration) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kefirIdealTimeKey, duration.inSeconds);
  }

  Future<Duration?> getKefirIdealDuration() async {
    final prefs = await SharedPreferences.getInstance();
    final seconds = prefs.getInt(_kefirIdealTimeKey);
    if (seconds != null) {
      return Duration(seconds: seconds);
    }
    return null;
  }

  // --- Historial ---

  Future<List<FermentationHistoryItem>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String? historyJson = prefs.getString(_historyKey);
    if (historyJson == null) return [];

    try {
      final List<dynamic> historyList = jsonDecode(historyJson);
      return historyList
          .map((item) =>
              FermentationHistoryItem.fromJson(item as Map<String, dynamic>))
          .toList()
        ..sort((a, b) =>
            b.completedAt.compareTo(a.completedAt)); // Orden descendente
    } catch (e) {
      return [];
    }
  }

  Future<void> addHistoryEntry(FermentationHistoryItem item) async {
    final prefs = await SharedPreferences.getInstance();
    final List<FermentationHistoryItem> currentHistory = await getHistory();
    currentHistory.add(item);

    final String updatedJson =
        jsonEncode(currentHistory.map((e) => e.toJson()).toList());
    await prefs.setString(_historyKey, updatedJson);
  }

  Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_historyKey);
  }

  Future<void> deleteHistoryEntry(DateTime completedAt) async {
    final prefs = await SharedPreferences.getInstance();
    final List<FermentationHistoryItem> currentHistory = await getHistory();
    currentHistory.removeWhere((item) => item.completedAt == completedAt);

    final String updatedJson =
        jsonEncode(currentHistory.map((e) => e.toJson()).toList());
    await prefs.setString(_historyKey, updatedJson);
  }

  Future<void> updateHistoryEntry(FermentationHistoryItem newItem) async {
    final prefs = await SharedPreferences.getInstance();
    final List<FermentationHistoryItem> currentHistory = await getHistory();

    final index = currentHistory.indexWhere(
        (item) => item.completedAt == newItem.completedAt);
    if (index != -1) {
      currentHistory[index] = newItem;
      final String updatedJson =
          jsonEncode(currentHistory.map((e) => e.toJson()).toList());
      await prefs.setString(_historyKey, updatedJson);
    }
  }

  // --- Backup / Restaurar ---

  Future<String> exportData() async {
    final prefs = await SharedPreferences.getInstance();
    final Map<String, dynamic> data = {
      _activeListKey: prefs.getString(_activeListKey),
      _historyKey: prefs.getString(_historyKey),
      _kombuchaIdealTimeKey: prefs.getInt(_kombuchaIdealTimeKey),
      _kefirIdealTimeKey: prefs.getInt(_kefirIdealTimeKey),
    };
    return jsonEncode(data);
  }

  Future<bool> importData(String jsonString) async {
    try {
      final Map<String, dynamic> data = jsonDecode(jsonString);
      final prefs = await SharedPreferences.getInstance();

      if (data.containsKey(_activeListKey) && data[_activeListKey] != null) {
        await prefs.setString(_activeListKey, data[_activeListKey] as String);
      }
      if (data.containsKey(_historyKey) && data[_historyKey] != null) {
        await prefs.setString(_historyKey, data[_historyKey] as String);
      }
      if (data.containsKey(_kombuchaIdealTimeKey) &&
          data[_kombuchaIdealTimeKey] != null) {
        await prefs.setInt(
            _kombuchaIdealTimeKey, data[_kombuchaIdealTimeKey] as int);
      }
      if (data.containsKey(_kefirIdealTimeKey) &&
          data[_kefirIdealTimeKey] != null) {
        await prefs.setInt(
            _kefirIdealTimeKey, data[_kefirIdealTimeKey] as int);
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
