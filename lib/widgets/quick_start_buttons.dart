import 'package:flutter/material.dart';

class QuickStartButtons extends StatelessWidget {
  final Function(int) onStartFermentation;
  final VoidCallback onManualStart;

  const QuickStartButtons({
    super.key,
    required this.onStartFermentation,
    required this.onManualStart,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FilledButton(
          onPressed: () => onStartFermentation(24),
          child: const Text('24h'),
        ),
        FilledButton(
          onPressed: () => onStartFermentation(36),
          child: const Text('36h'),
        ),
        FilledButton(
          onPressed: () => onStartFermentation(48),
          child: const Text('48h'),
        ),
        IconButton(
          onPressed: onManualStart,
          icon: const Icon(Icons.edit_calendar),
          tooltip: 'Inicio Manual',
        ),
      ],
    );
  }
}
