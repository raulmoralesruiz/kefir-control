import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/fermentation.dart';
import '../providers/fermentation_provider.dart';
import '../widgets/add_fermentation_sheet.dart';
import '../widgets/calendar_day_marker.dart';
import '../widgets/calendar_fermentation_section.dart';
import 'package:kefir_control/l10n/app_localizations.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  // ── Helpers ────────────────────────────────────────────────────

  /// Normaliza una fecha a medianoche para comparaciones de día.
  DateTime _dayOnly(DateTime dt) => DateTime(dt.year, dt.month, dt.day);

  /// Devuelve todas las fermentaciones que están activas en [day].
  List<Fermentation> _fermentationsForDay(
    List<Fermentation> all,
    DateTime day,
  ) {
    final d = _dayOnly(day);
    return all.where((f) {
      final start = _dayOnly(f.startTime);
      // fin: si tiene límite usamos estimatedFinishTime, si es sin límite
      // solo mostramos en el día de inicio (no podemos proyectar un fin).
      final end = f.isOpenEnded
          ? start
          : _dayOnly(
              f.estimatedFinishTime ?? f.startTime.add(f.targetDuration),
            );
      return !d.isBefore(start) && !d.isAfter(end);
    }).toList();
  }

  /// Construye el mapa día → fermentaciones para todo el set de activas.
  Map<DateTime, List<Fermentation>> _buildEventMap(
    List<Fermentation> fermentations,
  ) {
    final map = <DateTime, List<Fermentation>>{};
    for (final f in fermentations) {
      final start = _dayOnly(f.startTime);
      final end = f.isOpenEnded
          ? start
          : _dayOnly(
              f.estimatedFinishTime ?? f.startTime.add(f.targetDuration),
            );
      var cursor = start;
      while (!cursor.isAfter(end)) {
        map.putIfAbsent(cursor, () => []).add(f);
        cursor = cursor.add(const Duration(days: 1));
      }
    }
    return map;
  }

  // ── Acciones ───────────────────────────────────────────────────

  void _onStopFermentation(BuildContext context, Fermentation f) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.homeStopTitle),
        content: Text(l10n.homeStopContent),
        actions: [
          FilledButton.tonal(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
            child: Text(l10n.homeStopConfirm),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      ref.read(activeFermentationsProvider.notifier).stop(f.id);
    }
  }

  void _onHarvestFermentation(BuildContext context, Fermentation f) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.homeHarvestKombuchaTitle),
        content: Text(l10n.homeHarvestKombuchaDesc),
        actions: [
          FilledButton.tonal(
            onPressed: () {
              Navigator.pop(ctx, false);
              ref
                  .read(activeFermentationsProvider.notifier)
                  .stop(f.id, recordHistory: true);
            },
            child: Text(l10n.homeHarvestOnly),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.homeHarvestAndSave),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      ref
          .read(activeFermentationsProvider.notifier)
          .stop(f.id, recordHistory: true, customIdealTime: f.elapsed);
    }
  }

  void _onPlanForDay(BuildContext context) {
    // Abre el sheet con la fecha pre-seleccionada.
    // AddFermentationSheet accede al _customStartDate internamente
    // a través del picker de fecha pasada; aquí simplemente abrimos
    // el sheet normal y el usuario elige el día dentro.
    AddFermentationSheet.showWithPreselectedDate(context, _selectedDay);
  }

  // ── Build ──────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final fermentations = ref.watch(activeFermentationsProvider);
    final eventMap = _buildEventMap(fermentations);
    final selectedFermentations = _fermentationsForDay(
      fermentations,
      _selectedDay,
    );
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.calendarTitle),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // ── Calendario mensual ──────────────────────────────────
          _CalendarWidget(
            focusedDay: _focusedDay,
            selectedDay: _selectedDay,
            eventMap: eventMap,
            colorScheme: colorScheme,
            onDaySelected: (selected, focused) {
              setState(() {
                _selectedDay = selected;
                _focusedDay = focused;
              });
            },
            onPageChanged: (focused) {
              setState(() => _focusedDay = focused);
            },
          ),
          const Divider(height: 1),
          // ── Lista de fermentaciones del día seleccionado ────────
          Expanded(
            child: CalendarFermentationSection(
              selectedDay: _selectedDay,
              fermentations: selectedFermentations,
              onStop: () {},
              onStopFermentation: (f) => _onStopFermentation(context, f),
              onHarvestFermentation: (f) => _onHarvestFermentation(context, f),
              onPlanForDay: () => _onPlanForDay(context),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Widget del calendario (extraído para mantener build pequeño) ─

class _CalendarWidget extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime selectedDay;
  final Map<DateTime, List<Fermentation>> eventMap;
  final ColorScheme colorScheme;
  final void Function(DateTime, DateTime) onDaySelected;
  final void Function(DateTime) onPageChanged;

  const _CalendarWidget({
    required this.focusedDay,
    required this.selectedDay,
    required this.eventMap,
    required this.colorScheme,
    required this.onDaySelected,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TableCalendar<Fermentation>(
      locale: Localizations.localeOf(context).toString(),
      firstDay: DateTime.now().subtract(const Duration(days: 365)),
      lastDay: DateTime.now().add(const Duration(days: 365)),
      focusedDay: focusedDay,
      selectedDayPredicate: (day) => isSameDay(day, selectedDay),
      eventLoader: (day) {
        final key = DateTime(day.year, day.month, day.day);
        return eventMap[key] ?? [];
      },
      calendarFormat: CalendarFormat.month,
      availableCalendarFormats: const {CalendarFormat.month: ''},
      startingDayOfWeek: StartingDayOfWeek.monday,
      headerStyle: HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        titleTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurface,
        ),
      ),
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          shape: BoxShape.circle,
        ),
        todayTextStyle: TextStyle(color: colorScheme.onPrimaryContainer),
        selectedDecoration: BoxDecoration(
          color: colorScheme.secondaryContainer,
          shape: BoxShape.circle,
        ),
        selectedTextStyle: TextStyle(color: colorScheme.onSecondaryContainer),
        markerDecoration: const BoxDecoration(), // desactivado — usamos builder
        markersMaxCount: 0,
      ),
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, day, events) {
          if (events.isEmpty) return const SizedBox.shrink();
          return Positioned(
            bottom: 4,
            child: CalendarDayMarker(fermentations: events),
          );
        },
      ),
      onDaySelected: onDaySelected,
      onPageChanged: onPageChanged,
    );
  }
}
