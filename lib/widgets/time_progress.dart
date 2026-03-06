import 'package:flutter/material.dart';
import '../models/fermentation.dart';
import 'fermentation_stepper.dart';
import 'fermentation_timeline.dart';

class TimeProgress extends StatelessWidget {
  final Fermentation fermentation;

  const TimeProgress({super.key, required this.fermentation});

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    return '${hours}h ${minutes}m';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: FermentationTimeline(fermentation: fermentation),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                FermentationStepper(fermentation: fermentation),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
