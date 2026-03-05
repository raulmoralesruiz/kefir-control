import 'package:flutter/material.dart';
import '../models/fermentation.dart';

class TimeProgress extends StatelessWidget {
  final Fermentation fermentation;

  const TimeProgress({super.key, required this.fermentation});

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    return '${hours}h ${minutes}m';
  }

  String _formatTime(DateTime time) {
    final h = time.hour.toString().padLeft(2, '0');
    final m = time.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Fermentando desde ${_formatTime(fermentation.startTime)}',
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
        const SizedBox(height: 8),
        Text(
          fermentation.stage,
          style: const TextStyle(
              fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey),
        ),
        const SizedBox(height: 24),
        Text(
          'Restante: ${_formatDuration(fermentation.remaining)}',
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 8),
        Text(
          'Listo a las: ${_formatTime(fermentation.estimatedFinishTime)}',
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }
}
