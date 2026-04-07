import 'package:flutter/material.dart';
import '../models/fermentation.dart';
import 'package:kefir_control/l10n/app_localizations.dart';
import 'fermentation_card.dart';

/// Sección inferior del calendario que lista las fermentaciones
/// activas/planificadas para el día seleccionado y, si es un día
/// futuro o sin fermentaciones, muestra el botón de planificación.
class CalendarFermentationSection extends StatelessWidget {
  final DateTime selectedDay;
  final List<Fermentation> fermentations;
  final VoidCallback onStop;
  final void Function(Fermentation) onStopFermentation;
  final void Function(Fermentation) onHarvestFermentation;
  final VoidCallback onPlanForDay;

  const CalendarFermentationSection({
    super.key,
    required this.selectedDay,
    required this.fermentations,
    required this.onStop,
    required this.onStopFermentation,
    required this.onHarvestFermentation,
    required this.onPlanForDay,
  });

  bool get _isFutureDay {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final sel = DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
    return sel.isAfter(today);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (fermentations.isEmpty) {
      return _EmptyDayContent(
        l10n: l10n,
        isFutureDay: _isFutureDay,
        onPlanForDay: onPlanForDay,
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
      itemCount: fermentations.length + (_isFutureDay ? 1 : 0),
      itemBuilder: (context, index) {
        if (_isFutureDay && index == fermentations.length) {
          return _PlanButton(l10n: l10n, onPlanForDay: onPlanForDay);
        }
        final f = fermentations[index];
        return FermentationCard(
          fermentation: f,
          onStop: () => onStopFermentation(f),
          onHarvest: () => onHarvestFermentation(f),
        );
      },
    );
  }
}

// ── Widgets internos ────────────────────────────────────────────

class _EmptyDayContent extends StatelessWidget {
  final AppLocalizations l10n;
  final bool isFutureDay;
  final VoidCallback onPlanForDay;

  const _EmptyDayContent({
    required this.l10n,
    required this.isFutureDay,
    required this.onPlanForDay,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.event_available_outlined,
            size: 48,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 12),
          Text(
            l10n.calendarNoFermentations,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          if (isFutureDay) ...[
            const SizedBox(height: 20),
            _PlanButton(l10n: l10n, onPlanForDay: onPlanForDay),
          ],
        ],
      ),
    );
  }
}

class _PlanButton extends StatelessWidget {
  final AppLocalizations l10n;
  final VoidCallback onPlanForDay;

  const _PlanButton({required this.l10n, required this.onPlanForDay});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      child: FilledButton.icon(
        onPressed: onPlanForDay,
        icon: const Icon(Icons.add_circle_outline),
        label: Text(l10n.calendarPlanButton),
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          minimumSize: const Size(double.infinity, 0),
        ),
      ),
    );
  }
}
