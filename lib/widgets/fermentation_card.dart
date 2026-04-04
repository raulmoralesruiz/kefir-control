import 'package:flutter/material.dart';
import '../models/fermentation.dart';
import 'package:kefir_control/l10n/app_localizations.dart';

class FermentationCard extends StatelessWidget {
  final Fermentation fermentation;
  final VoidCallback onStop;
  final VoidCallback onHarvest; // For Kombucha smart learning

  const FermentationCard({
    super.key,
    required this.fermentation,
    required this.onStop,
    required this.onHarvest,
  });

  String _formatDuration(Duration d) {
    if (d.inDays > 0) {
      return '${d.inDays}d ${d.inHours % 24}h ${d.inMinutes % 60}m';
    }
    return '${d.inHours}h ${d.inMinutes % 60}m';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final isKombucha = fermentation.type == FermentationType.kombucha;

    return Card(
      elevation: 0,
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: colorScheme.outlineVariant, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isKombucha ? Icons.coffee_outlined : Icons.local_drink,
                  color: colorScheme.primary,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isKombucha ? l10n.addSheetKombucha : l10n.addSheetKefir,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        fermentation.getStageLocalized(l10n),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: isKombucha ? onHarvest : onStop,
                  icon: const Icon(Icons.stop_circle_outlined),
                  color: colorScheme.error,
                  tooltip: isKombucha ? l10n.cardCosechar : l10n.cardFinalizar,
                ),
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: fermentation.progress,
              backgroundColor: colorScheme.surfaceContainerHighest,
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.cardTranscurrido, style: const TextStyle(fontSize: 12)),
                    Text(
                      _formatDuration(fermentation.elapsed),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(l10n.cardRestante, style: const TextStyle(fontSize: 12)),
                    Text(
                      _formatDuration(fermentation.remaining),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
