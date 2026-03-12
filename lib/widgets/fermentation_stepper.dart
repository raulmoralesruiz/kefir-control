import 'package:flutter/material.dart';
import 'package:kefir_control/l10n/app_localizations.dart';
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

  String _getStageName(BuildContext context, int index) {
    switch (index) {
      case 0: return AppLocalizations.of(context)!.step0Title;
      case 1: return AppLocalizations.of(context)!.step1Title;
      case 2: return AppLocalizations.of(context)!.step2Title;
      case 3: return AppLocalizations.of(context)!.step3Title;
      case 4: return AppLocalizations.of(context)!.step4Title;
      default: return "";
    }
  }

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
              _getStageName(context, index),
              style: TextStyle(
                fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            content: Text(
              _getStageDescription(context, index),
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

  String _getStageDescription(BuildContext context, int index) {
    switch (index) {
      case 0: return AppLocalizations.of(context)!.step0Desc;
      case 1: return AppLocalizations.of(context)!.step1Desc;
      case 2: return AppLocalizations.of(context)!.step2Desc;
      case 3: return AppLocalizations.of(context)!.step3Desc;
      case 4: return AppLocalizations.of(context)!.step4Desc;
      default: return "";
    }
  }
}
