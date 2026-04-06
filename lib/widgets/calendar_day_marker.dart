import 'package:flutter/material.dart';
import '../models/fermentation.dart';

/// Muestra puntos de color debajo de un día del calendario
/// indicando qué tipos de fermentación están activos ese día.
class CalendarDayMarker extends StatelessWidget {
  final List<Fermentation> fermentations;

  const CalendarDayMarker({super.key, required this.fermentations});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final hasKefir =
        fermentations.any((f) => f.type == FermentationType.kefir);
    final hasKombucha =
        fermentations.any((f) => f.type == FermentationType.kombucha);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (hasKefir)
          _Dot(color: colorScheme.primary),
        if (hasKefir && hasKombucha)
          const SizedBox(width: 3),
        if (hasKombucha)
          const _Dot(color: Color(0xFFF59E0B)), // amber-500
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  final Color color;

  const _Dot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
