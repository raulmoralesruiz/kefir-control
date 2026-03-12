import 'package:flutter/material.dart';
import 'package:kefir_control/l10n/app_localizations.dart';

class StartFermentationButtons extends StatelessWidget {
  final VoidCallback onStartNow;
  final VoidCallback onStartPast;

  const StartFermentationButtons({
    super.key,
    required this.onStartNow,
    required this.onStartPast,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FilledButton.icon(
          onPressed: onStartNow,
          icon: const Icon(Icons.play_circle_fill),
          label: Text(AppLocalizations.of(context)!.btnStartFermentation),
          style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              textStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: onStartPast,
          icon: const Icon(Icons.history),
          label: Text(AppLocalizations.of(context)!.btnStartPastFermentation),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
      ],
    );
  }
}
