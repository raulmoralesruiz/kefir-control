import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/fermentation.dart';
import '../providers/fermentation_provider.dart';
import 'package:kefir_control/l10n/app_localizations.dart';

class FermentationCard extends ConsumerWidget {
  final Fermentation fermentation;
  final VoidCallback onStop;
  final VoidCallback onHarvest;

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

  Future<void> _showRenameDialog(
      BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final controller =
        TextEditingController(text: fermentation.name ?? '');
    final newName = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.cardRenameTitle),
        content: TextField(
          controller: controller,
          autofocus: true,
          maxLength: 40,
          decoration: InputDecoration(
            hintText: l10n.cardRenameHint,
            border: const OutlineInputBorder(),
          ),
          onSubmitted: (v) => Navigator.pop(ctx, v),
        ),
        actions: [
          FilledButton.tonal(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, controller.text),
            child: Text(l10n.accept),
          ),
        ],
      ),
    );
    if (newName != null) {
      ref
          .read(activeFermentationsProvider.notifier)
          .rename(fermentation.id, newName);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final isKombucha = fermentation.type == FermentationType.kombucha;
    final isOpenEnded = fermentation.isOpenEnded;

    final progress = fermentation.progress;
    final remaining = fermentation.remaining;

    // Título: nombre personalizado si existe, si no el tipo
    final displayTitle = fermentation.name?.isNotEmpty == true
        ? fermentation.name!
        : (isKombucha ? l10n.addSheetKombucha : l10n.addSheetKefir);

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
                  isKombucha
                      ? Icons.emoji_food_beverage
                      : Icons.local_drink,
                  color: colorScheme.primary,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () => _showRenameDialog(context, ref),
                        borderRadius: BorderRadius.circular(4),
                        child: Text(
                          displayTitle,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        fermentation.getStageLocalized(l10n),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(
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
                  tooltip:
                      isKombucha ? l10n.cardCosechar : l10n.cardFinalizar,
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (isOpenEnded)
              LinearProgressIndicator(
                backgroundColor: colorScheme.surfaceContainerHighest,
                minHeight: 8,
                borderRadius: BorderRadius.circular(4),
              )
            else
              LinearProgressIndicator(
                value: progress,
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
                    Text(l10n.cardTranscurrido,
                        style: const TextStyle(fontSize: 12)),
                    Text(
                      _formatDuration(fermentation.elapsed),
                      style:
                          const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      isOpenEnded ? '' : l10n.cardRestante,
                      style: const TextStyle(fontSize: 12),
                    ),
                    Text(
                      isOpenEnded
                          ? l10n.cardNoLimit
                          : _formatDuration(
                              remaining ?? Duration.zero),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:
                            isOpenEnded ? colorScheme.secondary : null,
                      ),
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
