import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/fermentation.dart';
import '../models/fermentation_history_item.dart';

class FermentationService {
  static const String _startTimeKey = 'fermentation_start_time';
  static const String _durationKey = 'fermentation_duration_hours';
  static const String _historyKey = 'fermentation_history';

  Future<void> saveFermentation(Fermentation fermentation) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(
        _startTimeKey, fermentation.startTime.millisecondsSinceEpoch);
    await prefs.setInt(_durationKey, fermentation.targetDuration.inHours);
  }

  Future<Fermentation?> loadFermentation() async {
    final prefs = await SharedPreferences.getInstance();
    final startTimeMillis = prefs.getInt(_startTimeKey);
    final durationHours = prefs.getInt(_durationKey);

    if (startTimeMillis != null && durationHours != null) {
      return Fermentation(
        startTime: DateTime.fromMillisecondsSinceEpoch(startTimeMillis),
        targetDuration: Duration(hours: durationHours),
      );
    }
    return null;
  }

  Future<void> clearFermentation() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_startTimeKey);
    await prefs.remove(_durationKey);
  }

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
}
