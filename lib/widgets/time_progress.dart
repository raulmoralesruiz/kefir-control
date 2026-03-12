import 'package:flutter/material.dart';
import '../models/fermentation.dart';
import 'fermentation_stepper.dart';
import 'fermentation_timeline.dart';
import 'fermentation_elapsed_time.dart';

class TimeProgress extends StatelessWidget {
  final Fermentation fermentation;

  const TimeProgress({
    super.key,
    required this.fermentation,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 500 ||
            MediaQuery.of(context).orientation == Orientation.landscape) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 24),
                      FermentationElapsedTime(fermentation: fermentation),
                      const SizedBox(height: 32),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: FermentationTimeline(fermentation: fermentation),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
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

        // Portrait
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            FermentationElapsedTime(fermentation: fermentation),
            const SizedBox(height: 32),
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
                    const SizedBox(height: 100), // espacio para el FAB
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
