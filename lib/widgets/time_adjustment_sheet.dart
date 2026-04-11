import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kefir_control/l10n/app_localizations.dart';
import '../models/fermentation.dart';
import '../providers/fermentation_provider.dart';
import '../providers/service_providers.dart';
import '../widgets/custom_duration_picker.dart';
import '../services/haptic_service.dart';

class TimeAdjustmentSheet extends ConsumerWidget {
  final Fermentation fermentation;

  const TimeAdjustmentSheet({
    super.key,
    required this.fermentation,
  });

  static void show(BuildContext context, Fermentation fermentation) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => TimeAdjustmentSheet(fermentation: fermentation),
    );
  }

  void _update(
      WidgetRef ref, BuildContext context, int seconds, bool isOpenEnded) {
    final l10n = AppLocalizations.of(context)!;
    
    // Feedback háptico al actualizar el tiempo
    HapticService.medium();

    final l10nTitle = fermentation.type == FermentationType.kombucha
        ? l10n.notifReadyTitleKombucha
        : l10n.notifReadyTitleKefir;
    final l10nBody = l10n.notifReadyBodyGeneric;
    final l10nRemTitle = l10n.notifReminderTitleGeneric;
    final l10nRemBody = l10n.notifReminderBodyGeneric;

    ref.read(activeFermentationsProvider.notifier).updateDuration(
          fermentation.id,
          seconds,
          isOpenEnded: isOpenEnded,
          notifReadyTitle: l10nTitle,
          notifReadyBody: l10nBody,
          notifReminderTitle: l10nRemTitle,
          notifReminderBody: l10nRemBody,
        );

    Navigator.pop(context); // Cierra el sheet de ajuste
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final isKefir = fermentation.type == FermentationType.kefir;
    final service = ref.read(fermentationServiceProvider);

    final futureIdeal = isKefir
        ? service.getKefirIdealDuration()
        : service.getKombuchaIdealDuration();

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        ),
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Handle
            Center(
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Header
            Row(
              children: [
                const SizedBox(width: 48),
                Expanded(
                  child: Text(
                    l10n.adjSheetTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),
            const SizedBox(height: 16),

            // Opciones dinámicas
            if (fermentation.isOpenEnded)
              FutureBuilder<Duration?>(
                future: futureIdeal,
                builder: (context, snapshot) {
                  final ideal = snapshot.data;
                  if (ideal == null) return const SizedBox.shrink();

                  final String label;
                  if (isKefir) {
                    final hours = (ideal.inMinutes / 60.0);
                    label = l10n.addSheetIdealTimeKefir(
                        num.parse(hours.toStringAsFixed(1)));
                  } else {
                    final days = (ideal.inSeconds / 86400.0);
                    label = l10n
                        .addSheetIdealTime(num.parse(days.toStringAsFixed(1)));
                  }

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: FilledButton.icon(
                      onPressed: () =>
                          _update(ref, context, ideal.inSeconds, false),
                      icon: const Icon(Icons.star_rounded),
                      style: FilledButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      label: Text(label),
                    ),
                  );
                },
              ),

            // Tiempo personalizado (Estilo FilledButton como en AddFermentationSheet)
            FilledButton.tonalIcon(
              onPressed: () => CustomDurationPicker.show(context,
                  type: fermentation.type,
                  onConfirm: (dur) =>
                      _update(ref, context, dur.inSeconds, false)),
              icon: const Icon(Icons.tune),
              label: Text(l10n.addSheetCustomTime),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),

            if (!fermentation.isOpenEnded) ...[
              const SizedBox(height: 12),
              FilledButton.tonalIcon(
                onPressed: () => _update(ref, context, 0, true),
                icon: const Icon(Icons.all_inclusive),
                label: Text(l10n.addSheetNoLimit),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ],

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
