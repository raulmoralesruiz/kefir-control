import 'package:flutter/material.dart';
import 'package:kefir_control/l10n/app_localizations.dart';
import '../models/fermentation.dart';
import '../models/fermentation_history_item.dart';

// Color amber-500 consistente con FermentationCard y CalendarDayMarker
const _kombuchaColor = Color(0xFFF59E0B);

class HistoryListItem extends StatelessWidget {
  final FermentationHistoryItem item;
  final VoidCallback onDismissed;

  const HistoryListItem({
    super.key,
    required this.item,
    required this.onDismissed,
  });

  String _formatNiceDate(DateTime dt) {
    const months = [
      'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun',
      'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'
    ];
    final month = months[dt.month - 1];
    final day = dt.day;
    final hour = dt.hour.toString().padLeft(2, '0');
    final minute = dt.minute.toString().padLeft(2, '0');
    return '$day $month a las $hour:$minute';
  }

  String _formatDuration(Duration d, bool isKombucha, AppLocalizations l10n) {
    if (isKombucha) {
      final days = d.inDays;
      final hours = d.inHours % 24;
      if (hours == 0) return l10n.historyDurationDays(days);
      return l10n.historyDurationDaysHours(days, hours);
    } else {
      final hours = d.inHours;
      final minutes = d.inMinutes % 60;
      if (minutes == 0) return l10n.historyDurationHours(hours);
      return l10n.historyDurationHoursMinutes(hours, minutes);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isKombucha = item.type == FermentationType.kombucha;
    final percent = item.completionPercentage;
    final l10n = AppLocalizations.of(context)!;

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final typeColor = isKombucha ? _kombuchaColor : colorScheme.primary;

    return Dismissible(
      key: Key(item.completedAt.millisecondsSinceEpoch.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: colorScheme.error,
        child: Icon(Icons.delete, color: colorScheme.onError),
      ),
      onDismissed: (_) => onDismissed(),
      confirmDismiss: (direction) async {
        return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(l10n.historyItemDeleteTitle),
            content: Text(l10n.historyItemDeleteContent),
            actions: [
              FilledButton.tonal(
                onPressed: () => Navigator.pop(context, false),
                child: Text(l10n.cancel),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(context, true),
                style: FilledButton.styleFrom(
                  backgroundColor: colorScheme.error,
                  foregroundColor: colorScheme.onError,
                ),
                child: Text(l10n.homeDeleteBtn),
              ),
            ],
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: colorScheme.outlineVariant, width: 1),
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Banda lateral de color ────────────────────────────
              Container(width: 5, color: typeColor),
              // ── Contenido (layout manual para control total) ──────
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Indicador circular + icono centrado
                      _TypeIndicator(
                        isKombucha: isKombucha,
                        percent: percent,
                        typeColor: typeColor,
                        surfaceColor: colorScheme.surfaceContainerHighest,
                      ),
                      const SizedBox(width: 16),
                      // Textos — se expanden y rompen línea libremente
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              isKombucha
                                  ? l10n.addSheetKombucha
                                  : l10n.addSheetKefir,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              l10n.historyRealDurationTarget(
                                _formatDuration(
                                    item.actualDuration, isKombucha, l10n),
                                _formatDuration(
                                    item.targetDuration, isKombucha, l10n),
                              ),
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              l10n.historyCompletedOn(
                                  _formatNiceDate(item.completedAt)),
                              style: TextStyle(
                                color: theme.textTheme.bodySmall?.color,
                                fontStyle: FontStyle.italic,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
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

// ── Widget interno ──────────────────────────────────────────────

class _TypeIndicator extends StatelessWidget {
  final bool isKombucha;
  final double? percent;
  final Color typeColor;
  final Color surfaceColor;

  const _TypeIndicator({
    required this.isKombucha,
    required this.percent,
    required this.typeColor,
    required this.surfaceColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 48,
            height: 48,
            child: CircularProgressIndicator(
              value: percent,
              backgroundColor: surfaceColor,
              strokeWidth: 3,
              color: typeColor,
            ),
          ),
          Icon(
            isKombucha ? Icons.emoji_food_beverage : Icons.local_drink,
            color: typeColor,
            size: 22,
          ),
        ],
      ),
    );
  }
}
