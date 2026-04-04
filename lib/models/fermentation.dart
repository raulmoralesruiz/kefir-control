import 'package:uuid/uuid.dart';
import 'package:kefir_control/l10n/app_localizations.dart';

enum FermentationType { kefir, kombucha }

class Fermentation {
  final String id;
  final FermentationType type;
  final DateTime startTime;
  final Duration targetDuration;

  Fermentation({
    String? id,
    this.type = FermentationType.kefir,
    required this.startTime,
    required this.targetDuration,
  }) : id = id ?? const Uuid().v4();

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
    if (type == FermentationType.kefir) {
      final hours = elapsed.inHours;
      if (hours < 12) return "Etapa láctea";
      if (hours < 24) return "Iniciando fermentación";
      if (hours < 36) return "Fermentación ideal";
      if (hours < 48) return "Fermentación fuerte";
      return "Muy ácido";
    } else {
      final days = elapsed.inDays;
      if (days < 3) return "Formación inicial";
      if (days < 6) return "Ligeramente dulce";
      if (days < 10) return "Equilibrada (Ideal)";
      if (days < 14) return "Fuerte/Ácida";
      return "Avinagrada";
    }
  }

  String getStageLocalized(AppLocalizations l10n) {
    if (type == FermentationType.kefir) {
      final hours = elapsed.inHours;
      if (hours < 12) return l10n.step0Title;
      if (hours < 24) return l10n.step1Title;
      if (hours < 36) return l10n.step2Title;
      if (hours < 48) return l10n.step3Title;
      return l10n.step4Title;
    } else {
      final days = elapsed.inDays;
      if (days < 3) return l10n.stageKombucha0;
      if (days < 6) return l10n.stageKombucha1;
      if (days < 10) return l10n.stageKombucha2;
      if (days < 14) return l10n.stageKombucha3;
      return l10n.stageKombucha4;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'startTime': startTime.millisecondsSinceEpoch,
      'targetDuration': targetDuration.inSeconds,
    };
  }

  factory Fermentation.fromJson(Map<String, dynamic> json) {
    return Fermentation(
      id: json['id'] as String?,
      type: FermentationType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => FermentationType.kefir,
      ),
      startTime: DateTime.fromMillisecondsSinceEpoch(json['startTime'] as int),
      targetDuration: Duration(seconds: json['targetDuration'] as int),
    );
  }
}
