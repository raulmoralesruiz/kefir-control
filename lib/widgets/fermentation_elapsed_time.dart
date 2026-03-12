import 'package:flutter/material.dart';
import 'package:kefir_control/l10n/app_localizations.dart';
import '../models/fermentation.dart';

class FermentationElapsedTime extends StatelessWidget {
  final Fermentation fermentation;

  const FermentationElapsedTime({super.key, required this.fermentation});

  @override
  Widget build(BuildContext context) {
    final dur = fermentation.elapsed;
    final d = dur.inDays.toString().padLeft(2, '0');
    final h = dur.inHours.remainder(24).toString().padLeft(2, '0');
    final m = dur.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = dur.inSeconds.remainder(60).toString().padLeft(2, '0');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Column(
          children: [
            Text(
              dur.inDays > 0 ? '$d : $h : $m : $s' : '$h : $m : $s',
              style: const TextStyle(
                  fontSize: 64, fontWeight: FontWeight.w300, letterSpacing: 4),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (dur.inDays > 0) ...[
                  Text(AppLocalizations.of(context)!.timeDays,
                      style: const TextStyle(
                          color: Colors.grey, fontSize: 12, letterSpacing: 2)),
                  const SizedBox(width: 32),
                ],
                Text(AppLocalizations.of(context)!.timeHours,
                    style: const TextStyle(
                        color: Colors.grey, fontSize: 12, letterSpacing: 2)),
                const SizedBox(width: 32),
                Text(AppLocalizations.of(context)!.timeMinutes,
                    style: const TextStyle(
                        color: Colors.grey, fontSize: 12, letterSpacing: 2)),
                const SizedBox(width: 32),
                Text(AppLocalizations.of(context)!.timeSeconds,
                    style: const TextStyle(
                        color: Colors.grey, fontSize: 12, letterSpacing: 2)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
