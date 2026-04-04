import 'package:flutter/material.dart';
import 'package:kefir_control/l10n/app_localizations.dart';
import '../models/fermentation.dart';
import '../models/fermentation_history_item.dart';

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
    final primaryColor = theme.colorScheme.primary;
    final surfaceColor = theme.colorScheme.surfaceContainerHighest;

    return Dismissible(
      key: Key(item.completedAt.millisecondsSinceEpoch.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: theme.colorScheme.error,
        child: Icon(Icons.delete, color: theme.colorScheme.onError),
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
                  backgroundColor: theme.colorScheme.error,
                  foregroundColor: theme.colorScheme.onError,
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
        child: ListTile(
          leading: SizedBox(
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
                    color: primaryColor,
                  ),
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.transparent,
                  child: Icon(
                    isKombucha ? Icons.emoji_food_beverage : Icons.local_drink,
                    color: primaryColor,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
          title: Text(
            isKombucha ? l10n.historyKombuchaFinished : l10n.historyKefirFinished,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                l10n.historyRealDurationTarget(
                  _formatDuration(item.actualDuration, isKombucha, l10n),
                  _formatDuration(item.targetDuration, isKombucha, l10n),
                ),
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 2),
              Text(
                l10n.historyCompletedOn(_formatNiceDate(item.completedAt)),
                style: TextStyle(
                  color: theme.textTheme.bodySmall?.color,
                  fontStyle: FontStyle.italic,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          titleAlignment: ListTileTitleAlignment.center,
        ),
      ),
    );
  }
}
