import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/fermentation.dart';
import '../models/fermentation_history_item.dart';

class FermentationService {
  static const String _activeListKey = 'fermentation_active_list';
  static const String _historyKey = 'fermentation_history';
  static const String _kombuchaIdealTimeKey = 'kombucha_ideal_duration_seconds';

  // --- Active Fermentations ---
  
  Future<void> saveActiveFermentations(List<Fermentation> fermentations) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = fermentations.map((f) => f.toJson()).toList();
    await prefs.setString(_activeListKey, jsonEncode(jsonList));
  }

  Future<List<Fermentation>> loadActiveFermentations() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Purge old single tracker data if present to avoid pollution, though we 
    // are using a new key so it shouldn't conflict, it's just good hygiene.
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

  // --- Smart Kombucha Settings ---
  
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

  // --- History ---

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
