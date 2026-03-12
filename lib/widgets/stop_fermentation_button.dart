import 'package:flutter/material.dart';
import 'package:kefir_control/l10n/app_localizations.dart';

class StopFermentationButton extends StatelessWidget {
  final VoidCallback onStop;

  const StopFermentationButton({super.key, required this.onStop});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OutlinedButton.icon(
          onPressed: onStop,
          icon: const Icon(Icons.stop_circle_outlined),
          label: Text(AppLocalizations.of(context)!.btnStopFermentation),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.red,
            side: const BorderSide(color: Colors.red),
            padding: const EdgeInsets.symmetric(vertical: 16),
            textStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
