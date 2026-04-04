import 'fermentation.dart';

class FermentationHistoryItem {
  final FermentationType type;
  final DateTime startTime;
  final Duration targetDuration;
  final DateTime completedAt;
  final bool isSuccess;

  FermentationHistoryItem({
    this.type = FermentationType.kefir,
    required this.startTime,
    required this.targetDuration,
    required this.completedAt,
    required this.isSuccess,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type.name,
      'startTime': startTime.millisecondsSinceEpoch,
      'targetDuration': targetDuration.inHours, // Keeping in hours for backward compatibility where possible, but we should probably migrate to seconds or keep it. Actually, historical items were saved as targetDuration.inHours.
      'completedAt': completedAt.millisecondsSinceEpoch,
      'isSuccess': isSuccess,
    };
  }

  factory FermentationHistoryItem.fromJson(Map<String, dynamic> json) {
    return FermentationHistoryItem(
      type: json.containsKey('type') 
          ? FermentationType.values.firstWhere((e) => e.name == json['type'], orElse: () => FermentationType.kefir)
          : FermentationType.kefir,
      startTime: DateTime.fromMillisecondsSinceEpoch(json['startTime'] as int),
      targetDuration: Duration(hours: json['targetDuration'] as int),
      completedAt: DateTime.fromMillisecondsSinceEpoch(json['completedAt'] as int),
      isSuccess: json['isSuccess'] as bool,
    );
  }
}
