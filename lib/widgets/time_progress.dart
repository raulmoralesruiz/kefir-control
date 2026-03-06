import 'package:flutter/material.dart';
import '../models/fermentation.dart';
import 'fermentation_stepper.dart';

class TimeProgress extends StatelessWidget {
  final Fermentation fermentation;

  const TimeProgress({super.key, required this.fermentation});

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    return '${hours}h ${minutes}m';
  }

  String _getSpanishDay(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'lunes';
      case DateTime.tuesday:
        return 'martes';
      case DateTime.wednesday:
        return 'miércoles';
      case DateTime.thursday:
        return 'jueves';
      case DateTime.friday:
        return 'viernes';
      case DateTime.saturday:
        return 'sábado';
      case DateTime.sunday:
        return 'domingo';
      default:
        return '';
    }
  }

  String _formatDateTime(DateTime time) {
    final day = _getSpanishDay(time.weekday);
    final h = time.hour.toString().padLeft(2, '0');
    final m = time.minute.toString().padLeft(2, '0');
    return '$day $h:$m';
  }

  String _formatRemainingDuration(Duration duration) {
    if (duration.isNegative) return '0 minutos';
    final days = duration.inDays;
    final hours = duration.inHours.remainder(24);
    final minutes = duration.inMinutes.remainder(60);

    List<String> parts = [];
    if (days > 0) {
      parts.add('$days ${days == 1 ? "día" : "días"}');
    }
    if (hours > 0) {
      parts.add('$hours ${hours == 1 ? "hora" : "horas"}');
    }
    if (minutes > 0 || parts.isEmpty) {
      parts.add('$minutes ${minutes == 1 ? "minuto" : "minutos"}');
    }
    return parts.join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Inicio fermentación: ${_formatDateTime(fermentation.startTime)}',
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 24),
        Text(
          _formatDuration(fermentation.elapsed),
          style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: LinearProgressIndicator(
            value: fermentation.progress,
            minHeight: 12,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                FermentationStepper(fermentation: fermentation),
                Text(
                  'Restante: ${_formatRemainingDuration(fermentation.remaining)}',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 8),
                Text(
                  'Fin fermentación: ${_formatDateTime(fermentation.estimatedFinishTime)}',
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
