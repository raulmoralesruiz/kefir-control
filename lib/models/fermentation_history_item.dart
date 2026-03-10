class FermentationHistoryItem {
  final DateTime startTime;
  final Duration targetDuration;
  final DateTime completedAt;
  final bool isSuccess;

  FermentationHistoryItem({
    required this.startTime,
    required this.targetDuration,
    required this.completedAt,
    required this.isSuccess,
  });

  Map<String, dynamic> toJson() {
    return {
      'startTime': startTime.millisecondsSinceEpoch,
      'targetDuration': targetDuration.inHours,
      'completedAt': completedAt.millisecondsSinceEpoch,
      'isSuccess': isSuccess,
    };
  }

  factory FermentationHistoryItem.fromJson(Map<String, dynamic> json) {
    return FermentationHistoryItem(
      startTime: DateTime.fromMillisecondsSinceEpoch(json['startTime'] as int),
      targetDuration: Duration(hours: json['targetDuration'] as int),
      completedAt:
          DateTime.fromMillisecondsSinceEpoch(json['completedAt'] as int),
      isSuccess: json['isSuccess'] as bool,
    );
  }
}
