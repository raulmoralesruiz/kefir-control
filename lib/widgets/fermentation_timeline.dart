import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kefir_control/l10n/app_localizations.dart';
import '../models/fermentation.dart';

class FermentationTimeline extends StatelessWidget {
  final Fermentation fermentation;

  const FermentationTimeline({super.key, required this.fermentation});

  String _formatRemainingDuration(Duration duration) {
    if (duration.isNegative) return '0 m';
    final days = duration.inDays;
    final hours = duration.inHours.remainder(24);
    final minutes = duration.inMinutes.remainder(60);

    List<String> parts = [];
    if (days > 0) parts.add('${days}d');
    if (hours > 0) parts.add('${hours}h');
    if (minutes > 0 || parts.isEmpty) parts.add('${minutes}m');
    return parts.join(' ');
  }

  String _formatDateTime(DateTime time) {
    final h = time.hour.toString().padLeft(2, '0');
    final m = time.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  String _getDayName(BuildContext context, DateTime time) {
    String day = DateFormat.E(Localizations.localeOf(context).toString()).format(time);
    return day.substring(0, 1).toUpperCase() + day.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.timelineStart,
                    style: const TextStyle(fontSize: 11, color: Colors.grey)),
                Text(
                    '${_getDayName(context, fermentation.startTime)} ${_formatDateTime(fermentation.startTime)}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 13)),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Divider(color: Colors.teal.shade200, thickness: 2),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.teal.shade200),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                        _formatRemainingDuration(fermentation.remaining),
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal)),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(AppLocalizations.of(context)!.timelineEnd,
                    style: const TextStyle(fontSize: 11, color: Colors.grey)),
                Text(
                    '${_getDayName(context, fermentation.estimatedFinishTime)} ${_formatDateTime(fermentation.estimatedFinishTime)}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
