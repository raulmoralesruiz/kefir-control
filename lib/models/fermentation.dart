class Fermentation {
  final DateTime startTime;
  final Duration targetDuration;

  Fermentation({required this.startTime, required this.targetDuration});

  Duration get elapsed => DateTime.now().difference(startTime);

  Duration get remaining {
    final diff = targetDuration - elapsed;
    return diff.isNegative ? Duration.zero : diff;
  }

  double get progress {
    if (targetDuration.inSeconds == 0) return 0.0;
    final val = elapsed.inSeconds / targetDuration.inSeconds;
    return val.clamp(0.0, 1.0);
  }

  DateTime get estimatedFinishTime => startTime.add(targetDuration);

  String get stage {
    final hours = elapsed.inHours;
    if (hours < 12) return "Etapa láctea";
    if (hours < 24) return "Iniciando fermentación";
    if (hours < 36) return "Fermentación ideal";
    if (hours < 48) return "Fermentación fuerte";
    return "Muy ácido";
  }
}
