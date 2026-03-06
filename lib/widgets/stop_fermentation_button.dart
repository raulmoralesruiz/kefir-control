import 'package:flutter/material.dart';

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
          label: const Text("Finalizar fermentación"),
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
