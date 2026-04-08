import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/fermentation.dart';
import '../widgets/infinite_progress_indicator.dart';
import '../widgets/fermentation_detail_sheet.dart';
import 'package:kefir_control/l10n/app_localizations.dart';

// Color amber-500 consistente con CalendarDayMarker
const _kombuchaColor = Color(0xFFF59E0B);

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
    final abs = d.abs();
    if (abs.inDays > 0) {
      return '${abs.inDays}d ${abs.inHours % 24}h ${abs.inMinutes % 60}m';
    }
    return '${abs.inHours}h ${abs.inMinutes % 60}m';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final isKombucha = fermentation.type == FermentationType.kombucha;
    final isOpenEnded = fermentation.isOpenEnded;
    final isPlanned = fermentation.elapsed.isNegative;

    // Color de acento según tipo: coincide con los puntos del calendario
    final typeColor = isKombucha ? _kombuchaColor : colorScheme.primary;

    final progress = fermentation.progress;
    final remaining = fermentation.remaining;

    final displayTitle = fermentation.name?.isNotEmpty == true
        ? fermentation.name!
        : (isKombucha ? l10n.addSheetKombucha : l10n.addSheetKefir);

    return InkWell(
      onTap: () => FermentationDetailSheet.show(
        context,
        fermentation: fermentation,
        onStop: onStop,
        onHarvest: onHarvest,
      ),
      borderRadius: BorderRadius.circular(16),
      child: Card(
        elevation: 0,
        color: Theme.of(context).cardColor,
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: colorScheme.outlineVariant, width: 1),
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Banda lateral de color ────────────────────────────
              Container(width: 5, color: typeColor),
              // ── Contenido de la tarjeta ───────────────────────────
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Cabecera con badge si está planificada
                      if (isPlanned)
                        _PlannedBadge(label: l10n.calendarPlannedBadge),
                      Row(
                        children: [
                          Icon(
                            isKombucha
                                ? Icons.emoji_food_beverage
                                : Icons.local_drink,
                            color: typeColor,
                            size: 28,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  displayTitle,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  isPlanned
                                      ? l10n.calendarPlannedBadge
                                      : fermentation
                                          .getStageLocalized(l10n),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color:
                                            colorScheme.onSurfaceVariant,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          if (!isPlanned)
                            IconButton(
                              onPressed: () => FermentationDetailSheet.show(
                                context,
                                fermentation: fermentation,
                                onStop: onStop,
                                onHarvest: onHarvest,
                              ),
                              icon: const Icon(Icons.more_horiz_rounded),
                              color: colorScheme.primary,
                              tooltip: l10n.infoGuideStep1Title,
                            ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Barra de progreso
                      if (isPlanned)
                        LinearProgressIndicator(
                          value: 0,
                          color: typeColor.withValues(alpha: 0.3),
                          backgroundColor:
                              colorScheme.surfaceContainerHighest,
                          minHeight: 8,
                          borderRadius: BorderRadius.circular(4),
                        )
                      else if (isOpenEnded)
                        InfiniteProgressIndicator(
                          color: typeColor,
                          backgroundColor: colorScheme.surfaceContainerHighest,
                          height: 8,
                        )
                      else
                        LinearProgressIndicator(
                          value: progress,
                          color: typeColor,
                          backgroundColor:
                              colorScheme.surfaceContainerHighest,
                          minHeight: 8,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      const SizedBox(height: 12),
                      // Fila inferior con tiempos
                      _TimeRow(
                        isPlanned: isPlanned,
                        isOpenEnded: isOpenEnded,
                        fermentation: fermentation,
                        l10n: l10n,
                        colorScheme: colorScheme,
                        formatDuration: _formatDuration,
                        remaining: remaining,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Widgets internos ────────────────────────────────────────────

class _PlannedBadge extends StatelessWidget {
  final String label;

  const _PlannedBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        decoration: BoxDecoration(
          color: colorScheme.tertiaryContainer,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.schedule,
                size: 13, color: colorScheme.onTertiaryContainer),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: colorScheme.onTertiaryContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimeRow extends StatelessWidget {
  final bool isPlanned;
  final bool isOpenEnded;
  final Fermentation fermentation;
  final AppLocalizations l10n;
  final ColorScheme colorScheme;
  final String Function(Duration) formatDuration;
  final Duration? remaining;

  const _TimeRow({
    required this.isPlanned,
    required this.isOpenEnded,
    required this.fermentation,
    required this.l10n,
    required this.colorScheme,
    required this.formatDuration,
    required this.remaining,
  });

  @override
  Widget build(BuildContext context) {
    if (isPlanned) {
      final timeUntilStart =
          fermentation.startTime.difference(DateTime.now());
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.cardStartsIn,
                  style: const TextStyle(fontSize: 12)),
              Text(
                formatDuration(timeUntilStart),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(l10n.dialogManualDuration,
                  style: const TextStyle(fontSize: 12)),
              Text(
                formatDuration(fermentation.targetDuration),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.cardTranscurrido,
                style: const TextStyle(fontSize: 12)),
            Text(
              formatDuration(fermentation.elapsed),
              style: const TextStyle(fontWeight: FontWeight.bold),
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
                  : formatDuration(remaining ?? Duration.zero),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isOpenEnded ? colorScheme.secondary : null,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
