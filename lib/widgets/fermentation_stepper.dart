import 'package:flutter/material.dart';
import '../models/fermentation.dart';

class FermentationStepper extends StatelessWidget {
  final Fermentation fermentation;

  const FermentationStepper({super.key, required this.fermentation});

  int _getCurrentStageIndex() {
    final hours = fermentation.elapsed.inHours;
    if (hours < 12) return 0;
    if (hours < 24) return 1;
    if (hours < 36) return 2;
    if (hours < 48) return 3;
    return 4;
  }

  static const List<String> _stageNames = [
    "Etapa láctea",
    "Iniciando fermentación",
    "Fermentación ideal",
    "Fermentación fuerte",
    "Muy ácido",
  ];

  @override
  Widget build(BuildContext context) {
    final currentStage = _getCurrentStageIndex();

    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Colors.teal,
            ),
      ),
      child: Stepper(
        physics: const NeverScrollableScrollPhysics(),
        currentStep: currentStage.clamp(0, 4),
        controlsBuilder: (context, details) => const SizedBox.shrink(),
        steps: List.generate(5, (index) {
          final isCurrent = index == currentStage;
          return Step(
            title: Text(
              _stageNames[index],
              style: TextStyle(
                fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            content: Text(
              _getStageDescription(index),
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),
            isActive: index <= currentStage,
            state: index < currentStage
                ? StepState.complete
                : (isCurrent ? StepState.editing : StepState.indexed),
          );
        }),
      ),
    );
  }

  String _getStageDescription(int index) {
    switch (index) {
      case 0:
        return "La leche está infusionándose y empezando a espesar ligeramente.";
      case 1:
        return "El kéfir comienza a tomar forma con una acidez suave.";
      case 2:
        return "Momento perfecto para la mayoría de los gustos. Textura cremosa.";
      case 3:
        return "Sabor más pronunciado. Puede empezar a separarse el suero.";
      case 4:
        return "Sabor muy agresivo. Ideal para recetas que requieran acidez fuerte.";
      default:
        return "";
    }
  }
}
