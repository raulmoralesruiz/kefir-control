import 'fermentation.dart';

class FermentationHistoryItem {
  final FermentationType type;
  final DateTime startTime;
  final Duration targetDuration;
  final DateTime completedAt;
  final bool isSuccess;
  final bool isOpenEnded;
  final String? name;
  final String? notes;

  FermentationHistoryItem({
    this.type = FermentationType.kefir,
    required this.startTime,
    required this.targetDuration,
    required this.completedAt,
    required this.isSuccess,
    this.isOpenEnded = false,
    this.name,
    this.notes,
  });

  FermentationHistoryItem copyWith({
    FermentationType? type,
    DateTime? startTime,
    Duration? targetDuration,
    DateTime? completedAt,
    bool? isSuccess,
    bool? isOpenEnded,
    String? name,
    String? notes,
  }) {
    return FermentationHistoryItem(
      type: type ?? this.type,
      startTime: startTime ?? this.startTime,
      targetDuration: targetDuration ?? this.targetDuration,
      completedAt: completedAt ?? this.completedAt,
      isSuccess: isSuccess ?? this.isSuccess,
      isOpenEnded: isOpenEnded ?? this.isOpenEnded,
      name: name ?? this.name,
      notes: notes ?? this.notes,
    );
  }

  Duration get actualDuration {
    final diff = completedAt.difference(startTime);
    return diff.isNegative ? Duration.zero : diff;
  }

  /// Si es sin límite, se considera completado al 100% (cosecha manual = éxito).
  double get completionPercentage {
    if (isOpenEnded) return 1.0;
    if (targetDuration.inSeconds == 0) return 0.0;
    return (actualDuration.inSeconds / targetDuration.inSeconds).clamp(0.0, 1.0);
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type.name,
      'startTime': startTime.millisecondsSinceEpoch,
      'targetDuration': targetDuration.inHours,
      'completedAt': completedAt.millisecondsSinceEpoch,
      'isSuccess': isSuccess,
      'isOpenEnded': isOpenEnded,
      if (name != null) 'name': name,
      if (notes != null) 'notes': notes,
    };
  }

  factory FermentationHistoryItem.fromJson(Map<String, dynamic> json) {
    return FermentationHistoryItem(
      type: json.containsKey('type')
          ? FermentationType.values.firstWhere(
              (e) => e.name == json['type'],
              orElse: () => FermentationType.kefir,
            )
          : FermentationType.kefir,
      startTime: DateTime.fromMillisecondsSinceEpoch(json['startTime'] as int),
      targetDuration: Duration(hours: json['targetDuration'] as int),
      completedAt: DateTime.fromMillisecondsSinceEpoch(json['completedAt'] as int),
      isSuccess: json['isSuccess'] as bool,
      isOpenEnded: json['isOpenEnded'] as bool? ?? false,
      name: json['name'] as String?,
      notes: json['notes'] as String?,
    );
  }
}
