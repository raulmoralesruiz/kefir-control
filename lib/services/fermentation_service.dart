import 'package:shared_preferences/shared_preferences.dart';
import '../models/fermentation.dart';

class FermentationService {
  static const String _startTimeKey = 'fermentation_start_time';
  static const String _durationKey = 'fermentation_duration_hours';

  Future<void> saveFermentation(Fermentation fermentation) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_startTimeKey, fermentation.startTime.millisecondsSinceEpoch);
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
}
