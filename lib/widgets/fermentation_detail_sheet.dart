import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kefir_control/l10n/app_localizations.dart';
import '../models/fermentation.dart';
import '../widgets/infinite_progress_indicator.dart';
import '../models/fermentation_history_item.dart';
import '../providers/fermentation_provider.dart';
import '../providers/history_provider.dart';
import '../providers/service_providers.dart';
import '../widgets/time_adjustment_sheet.dart';
import '../widgets/custom_duration_picker.dart';

// Color amber-500 consistente con el resto de la app
const _kombuchaColor = Color(0xFFF59E0B);

/// BottomSheet con el detalle completo de una fermentación (activa o histórica).
/// Permite editar nombre, notas y ver datos de tiempo detallados.
class FermentationDetailSheet extends ConsumerStatefulWidget {
  final Fermentation? fermentation;
  final FermentationHistoryItem? historyItem;
  final VoidCallback? onStop;
  final VoidCallback? onHarvest;

  const FermentationDetailSheet({
    super.key,
    this.fermentation,
    this.historyItem,
    this.onStop,
    this.onHarvest,
  }) : assert(fermentation != null || historyItem != null);

  /// Abre el sheet para una fermentación activa.
  static Future<void> show(
    BuildContext context, {
    required Fermentation fermentation,
    required VoidCallback onStop,
    required VoidCallback onHarvest,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) => FermentationDetailSheet(
        fermentation: fermentation,
        onStop: onStop,
        onHarvest: onHarvest,
      ),
    );
  }

  /// Abre el sheet para un item del historial.
  static Future<void> showHistory(
    BuildContext context, {
    required FermentationHistoryItem historyItem,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) => FermentationDetailSheet(
        historyItem: historyItem,
      ),
    );
  }

  @override
  ConsumerState<FermentationDetailSheet> createState() =>
      _FermentationDetailSheetState();
}

class _FermentationDetailSheetState extends ConsumerState<FermentationDetailSheet> {
  late TextEditingController _nameController;
  late TextEditingController _notesController;
  bool _isEditingName = false;

  bool get isHistory => widget.historyItem != null;

  @override
  void initState() {
    super.initState();
    final name = isHistory ? widget.historyItem!.name : widget.fermentation!.name;
    final notes = isHistory ? widget.historyItem!.notes : widget.fermentation!.notes;
    
    _nameController = TextEditingController(text: name ?? '');
    _notesController = TextEditingController(text: notes ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _updateName() {
    final newName = _nameController.text.trim();
    final nameValue = newName.isEmpty ? null : newName;

    if (isHistory) {
      final updated = widget.historyItem!.copyWith(name: nameValue);
      ref.read(historyProvider.notifier).updateEntry(updated);
    } else {
      ref
          .read(activeFermentationsProvider.notifier)
          .rename(widget.fermentation!.id, nameValue);
    }
    setState(() => _isEditingName = false);
  }

  void _updateNotes() {
    final newNotes = _notesController.text.trim();
    final notesValue = newNotes.isEmpty ? null : newNotes;

    if (isHistory) {
      final updated = widget.historyItem!.copyWith(notes: notesValue);
      ref.read(historyProvider.notifier).updateEntry(updated);
    } else {
      ref
          .read(activeFermentationsProvider.notifier)
          .updateNotes(widget.fermentation!.id, notesValue);
    }
  }

  void _repeatFermentation() {
    final l10n = AppLocalizations.of(context)!;
    final item = widget.historyItem!;

    final l10nTitle = item.type == FermentationType.kombucha
        ? l10n.notifReadyTitleKombucha
        : l10n.notifReadyTitleKefir;
    final l10nBody = l10n.notifReadyBodyGeneric;
    final l10nRemTitle = l10n.notifReminderTitleGeneric;
    final l10nRemBody = l10n.notifReminderBodyGeneric;

    ref.read(activeFermentationsProvider.notifier).start(
          item.targetDuration.inSeconds,
          type: item.type,
          name: item.name,
          isOpenEnded: item.isOpenEnded,
          notifReadyTitle: l10nTitle,
          notifReadyBody: l10nBody,
          notifReminderTitle: l10nRemTitle,
          notifReminderBody: l10nRemBody,
        );

    Navigator.pop(context);
  }

  String _formatDuration(Duration d) {
    final abs = d.abs();
    if (abs.inDays > 0) {
      return '${abs.inDays}d ${abs.inHours % 24}h ${abs.inMinutes % 60}m';
    }
    return '${abs.inHours}h ${abs.inMinutes % 60}m';
  }

  String _formatDateTime(DateTime dt) {
    final d = dt.day.toString().padLeft(2, '0');
    final mo = dt.month.toString().padLeft(2, '0');
    final h = dt.hour.toString().padLeft(2, '0');
    final mi = dt.minute.toString().padLeft(2, '0');
    return '$d/$mo  $h:$mi';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    // Obtener los datos más recientes del provider para que la UI se actualice
    // si se cambia el nombre o notas mientras el sheet está abierto.
    final Fermentation? liveFermentation = isHistory
        ? null
        : ref.watch(activeFermentationsProvider).firstWhere(
              (f) => f.id == widget.fermentation!.id,
              orElse: () => widget.fermentation!,
            );

    final FermentationHistoryItem? liveHistoryItem = !isHistory
        ? null
        : ref.watch(historyProvider).maybeWhen(
              data: (history) => history.firstWhere(
                (h) =>
                    h.startTime == widget.historyItem!.startTime &&
                    h.completedAt == widget.historyItem!.completedAt,
                orElse: () => widget.historyItem!,
              ),
              orElse: () => widget.historyItem!,
            );

    final type = isHistory ? liveHistoryItem!.type : liveFermentation!.type;
    final fermentationName =
        isHistory ? liveHistoryItem!.name : liveFermentation!.name;
    final isKombucha = type == FermentationType.kombucha;
    final typeColor = isKombucha ? _kombuchaColor : colorScheme.primary;

    // Lógica específica según modo
    final bool isOpenEnded;
    final bool isPlanned;
    final String stageText;

    if (isHistory) {
      isOpenEnded = liveHistoryItem!.isOpenEnded;
      isPlanned = false;
      // Para el historial, la "etapa" es simplemente que está completada
      stageText = l10n.historyCompletedOn(
          _formatDateTime(liveHistoryItem.completedAt));
    } else {
      isOpenEnded = liveFermentation!.isOpenEnded;
      isPlanned = liveFermentation.elapsed.isNegative;
      stageText = isPlanned
          ? l10n.calendarPlannedBadge
          : liveFermentation.getStageLocalized(l10n);
    }

    final displayTitle = fermentationName?.isNotEmpty == true
        ? fermentationName!
        : (isKombucha ? l10n.addSheetKombucha : l10n.addSheetKefir);

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.75,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          builder: (ctx, scrollController) => SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _SheetHandle(color: colorScheme.outlineVariant),
                
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: typeColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        isKombucha ? Icons.emoji_food_beverage : Icons.local_drink,
                        color: typeColor,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _isEditingName
                          ? TextField(
                              controller: _nameController,
                              autofocus: true,
                              onSubmitted: (_) => _updateName(),
                              decoration: InputDecoration(
                                hintText: l10n.cardRenameHint,
                                isDense: true,
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.check),
                                  onPressed: _updateName,
                                ),
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () => setState(() => _isEditingName = true),
                                  borderRadius: BorderRadius.circular(4),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          displayTitle,
                                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Icon(Icons.edit, size: 16, color: colorScheme.onSurfaceVariant),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  stageText,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                ),
                              ],
                            ),
                    ),
                    if (!isHistory)
                      IconButton(
                        icon: Icon(Icons.delete_outline_rounded,
                            color: colorScheme.error.withAlpha(200)),
                        onPressed: () async {
                          final confirmed = await showDialog<bool>(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Text(l10n.homeDeleteTitle),
                              content: Text(l10n.homeDeleteDesc),
                              actions: [
                                FilledButton.tonal(
                                  onPressed: () => Navigator.pop(ctx, false),
                                  child: Text(l10n.cancel),
                                ),
                                FilledButton(
                                  onPressed: () => Navigator.pop(ctx, true),
                                  style: FilledButton.styleFrom(
                                    backgroundColor: colorScheme.error,
                                    foregroundColor: colorScheme.onError,
                                  ),
                                  child: Text(l10n.homeDeleteBtn),
                                ),
                              ],
                            ),
                          );
                          if (confirmed == true) {
                            if (!isHistory) {
                              ref
                                  .read(activeFermentationsProvider.notifier)
                                  .stop(widget.fermentation!.id,
                                      recordHistory: false);
                              if (context.mounted) {
                                Navigator.pop(context);
                              }
                            }
                          }
                        },
                      ),
                  ],
                ),
                const SizedBox(height: 24),
                
                // Descripción de etapa (Solo para activas no planificadas)
                if (!isHistory && !isPlanned)
                  _StageDescriptionCard(
                    fermentation: liveFermentation!,
                    l10n: l10n,
                    typeColor: typeColor,
                    colorScheme: colorScheme,
                  ),
                if (!isHistory && !isPlanned) const SizedBox(height: 24),
                
                // Progreso y Grid de tiempos (Interactivo para activas)
                InkWell(
                  onTap: isHistory
                      ? null
                      : () => TimeAdjustmentSheet.show(
                          context, liveFermentation!),
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      children: [
                        _ProgressSection(
                          fermentation: liveFermentation,
                          historyItem: liveHistoryItem,
                          typeColor: typeColor,
                          colorScheme: colorScheme,
                          isPlanned: isPlanned,
                          isOpenEnded: isOpenEnded,
                        ),
                        const SizedBox(height: 24),
                        _TimeDataGrid(
                          fermentation: liveFermentation,
                          historyItem: liveHistoryItem,
                          l10n: l10n,
                          isPlanned: isPlanned,
                          isOpenEnded: isOpenEnded,
                          colorScheme: colorScheme,
                          formatDuration: _formatDuration,
                          formatDateTime: _formatDateTime,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                
                // Notas
                Text(
                  l10n.detailNotesTitle,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _notesController,
                  maxLines: 3,
                  onChanged: (_) => _updateNotes(),
                  decoration: InputDecoration(
                    hintText: l10n.detailNotesHint,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: colorScheme.outlineVariant),
                    ),
                    filled: true,
                    fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                  ),
                ),
                const SizedBox(height: 24),
                
                // Historial Reciente (Solo para activas)
                if (!isHistory)
                  _RecentHistorySection(
                    type: type,
                    l10n: l10n,
                    colorScheme: colorScheme,
                    formatDuration: _formatDuration,
                  ),
                if (!isHistory) const SizedBox(height: 32),
                
                // Botones de acción (Solo para activas)
                if (!isHistory && !isPlanned)
                  _FermentationActionsGrid(
                    id: liveFermentation!.id,
                    type: type,
                    typeColor: typeColor,
                    onDeleted: () => Navigator.pop(context),
                  ),
                
                // Botón repetir (Solo para historial)
                if (isHistory)
                  FilledButton.icon(
                    onPressed: _repeatFermentation,
                    icon: const Icon(Icons.refresh),
                    label: Text(l10n.historyRepeat),
                    style: FilledButton.styleFrom(
                      backgroundColor: typeColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SheetHandle extends StatelessWidget {
  final Color color;
  const _SheetHandle({required this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 12, bottom: 20),
        width: 36,
        height: 4,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

class _StageDescriptionCard extends StatelessWidget {
  final Fermentation fermentation;
  final AppLocalizations l10n;
  final Color typeColor;
  final ColorScheme colorScheme;

  const _StageDescriptionCard({
    required this.fermentation,
    required this.l10n,
    required this.typeColor,
    required this.colorScheme,
  });

  String _stageDescription(AppLocalizations l10n) {
    if (fermentation.isOpenEnded) return '';
    if (fermentation.type == FermentationType.kefir) {
      final hours = fermentation.elapsed.inHours;
      if (hours < 12) return l10n.step0Desc;
      if (hours < 24) return l10n.step1Desc;
      if (hours < 36) return l10n.step2Desc;
      if (hours < 48) return l10n.step3Desc;
      return l10n.step4Desc;
    } else {
      final days = fermentation.elapsed.inDays;
      if (days < 3) return l10n.detailStageKombucha0Desc;
      if (days < 6) return l10n.detailStageKombucha1Desc;
      if (days < 10) return l10n.detailStageKombucha2Desc;
      if (days < 14) return l10n.detailStageKombucha3Desc;
      return l10n.detailStageKombucha4Desc;
    }
  }

  @override
  Widget build(BuildContext context) {
    final desc = _stageDescription(l10n);
    if (desc.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: typeColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: typeColor.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: typeColor, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              desc,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface,
                    height: 1.5,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressSection extends StatelessWidget {
  final Fermentation? fermentation;
  final FermentationHistoryItem? historyItem;
  final Color typeColor;
  final ColorScheme colorScheme;
  final bool isPlanned;
  final bool isOpenEnded;

  const _ProgressSection({
    this.fermentation,
    this.historyItem,
    required this.typeColor,
    required this.colorScheme,
    required this.isPlanned,
    required this.isOpenEnded,
  });

  @override
  Widget build(BuildContext context) {
    final double? progress;
    if (historyItem != null) {
      progress = historyItem!.completionPercentage;
    } else {
      progress = isPlanned ? 0.0 : (fermentation!.progress ?? 0.0);
    }
    
    final percent = (progress * 100).toStringAsFixed(0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isOpenEnded)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$percent%',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: typeColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                '100%',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
              ),
            ],
          ),
        if (!isOpenEnded) const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: isOpenEnded
              ? InfiniteProgressIndicator(
                  color: typeColor,
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  height: 16,
                )
              : LinearProgressIndicator(
                  value: progress,
                  color: typeColor,
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  minHeight: 16,
                ),
        ),
      ],
    );
  }
}

class _TimeDataGrid extends StatelessWidget {
  final Fermentation? fermentation;
  final FermentationHistoryItem? historyItem;
  final AppLocalizations l10n;
  final bool isPlanned;
  final bool isOpenEnded;
  final ColorScheme colorScheme;
  final String Function(Duration) formatDuration;
  final String Function(DateTime) formatDateTime;

  const _TimeDataGrid({
    this.fermentation,
    this.historyItem,
    required this.l10n,
    required this.isPlanned,
    required this.isOpenEnded,
    required this.colorScheme,
    required this.formatDuration,
    required this.formatDateTime,
  });

  @override
  Widget build(BuildContext context) {
    final items = <_DataItem>[];
    final bool historyMode = historyItem != null;

    final startTime = historyMode ? historyItem!.startTime : fermentation!.startTime;
    final targetDuration = historyMode ? historyItem!.targetDuration : fermentation!.targetDuration;

    items.add(_DataItem(
      icon: Icons.play_circle_outline,
      label: l10n.detailStartDate,
      value: formatDateTime(startTime),
    ));

    if (historyMode) {
      items.add(_DataItem(
        icon: Icons.check_circle_outline,
        label: l10n.historyHarvestDate,
        value: formatDateTime(historyItem!.completedAt),
      ));
      items.add(_DataItem(
        icon: Icons.timer_outlined,
        label: l10n.cardTranscurrido,
        value: formatDuration(historyItem!.actualDuration),
      ));
      items.add(_DataItem(
        icon: Icons.track_changes,
        label: l10n.dialogManualDuration,
        value: formatDuration(targetDuration),
      ));
    } else {
      if (isPlanned) {
        final timeUntil = startTime.difference(DateTime.now());
        items.add(_DataItem(
          icon: Icons.schedule,
          label: l10n.cardStartsIn,
          value: formatDuration(timeUntil),
        ));
      } else {
        items.add(_DataItem(
          icon: Icons.timer_outlined,
          label: l10n.cardTranscurrido,
          value: formatDuration(fermentation!.elapsed),
        ));
      }

      if (!isOpenEnded) {
        final estimated = fermentation!.estimatedFinishTime;
        if (estimated != null) {
          items.add(_DataItem(
            icon: Icons.event_available,
            label: l10n.homeEstimatedFinish,
            value: formatDateTime(estimated),
          ));
        }
        if (!isPlanned) {
          items.add(_DataItem(
            icon: Icons.hourglass_bottom,
            label: l10n.cardRestante,
            value: formatDuration(fermentation!.remaining ?? Duration.zero),
          ));
        }
      } else {
        items.add(_DataItem(
          icon: Icons.all_inclusive,
          label: l10n.dialogManualDuration,
          value: l10n.cardNoLimit,
        ));
      }
    }

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 2.4,
      children: items.map((it) => _DataCell(item: it, colorScheme: colorScheme)).toList(),
    );
  }
}

class _DataItem {
  final IconData icon;
  final String label;
  final String value;
  const _DataItem({required this.icon, required this.label, required this.value});
}

class _DataCell extends StatelessWidget {
  final _DataItem item;
  final ColorScheme colorScheme;

  const _DataCell({required this.item, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(item.icon, size: 14, color: colorScheme.onSurfaceVariant),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  item.label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontSize: 11,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            item.value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _RecentHistorySection extends ConsumerWidget {
  final FermentationType type;
  final AppLocalizations l10n;
  final ColorScheme colorScheme;
  final String Function(Duration) formatDuration;

  const _RecentHistorySection({
    required this.type,
    required this.l10n,
    required this.colorScheme,
    required this.formatDuration,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(historyProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.detailHistoryTitle,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        historyAsync.when(
          data: (history) {
            final filtered = history.where((h) => h.type == type).toList();
            if (filtered.isEmpty) {
              return Text(
                l10n.detailHistoryEmpty,
                style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 13),
              );
            }

            final lastBatch = filtered.last;
            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: colorScheme.outlineVariant),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.history, size: 18, color: colorScheme.onSurfaceVariant),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      l10n.detailHistoryLastHarvest(formatDuration(lastBatch.actualDuration)),
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            );
          },
          loading: () => const LinearProgressIndicator(),
          error: (_, __) => const SizedBox.shrink(),
        ),
      ],
    );
  }
}

class _FermentationActionsGrid extends ConsumerWidget {
  final String id;
  final FermentationType type;
  final Color typeColor;
  final VoidCallback onDeleted;

  const _FermentationActionsGrid({
    required this.id,
    required this.type,
    required this.typeColor,
    required this.onDeleted,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _ActionButton(
                icon: Icons.star_rounded,
                label: l10n.actionSaveIdealTime,
                color: typeColor,
                onPressed: () async {
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text(l10n.actionSaveIdealTime),
                      content: Text(l10n.dialogSaveIdealConfirm),
                      actions: [
                        FilledButton.tonal(
                          onPressed: () => Navigator.pop(ctx, false),
                          child: Text(l10n.cancel),
                        ),
                        FilledButton(
                          onPressed: () => Navigator.pop(ctx, true),
                          child: Text(l10n.accept),
                        ),
                      ],
                    ),
                  );

                  if (confirmed == true) {
                    ref
                        .read(activeFermentationsProvider.notifier)
                        .saveIdealTime(id);
                    if (context.mounted) {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text(l10n.actionSaveIdealTime),
                          content: Text(l10n.actionSaveIdealTimeSuccess),
                          actions: [
                            FilledButton.tonal(
                              onPressed: () => Navigator.pop(ctx),
                              child: Text(l10n.accept),
                            ),
                          ],
                        ),
                      );
                    }
                  }
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _ActionButton(
                icon: Icons.autorenew_rounded,
                label: l10n.actionHarvestAndRestart,
                color: typeColor,
                onPressed: () => _handleHarvestAndRestart(context, ref),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _handleHarvestAndRestart(
      BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;

    // 1. Confirmar cosecha
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.actionHarvestAndRestart),
        content: Text(l10n.dialogHarvestAndRestartConfirm),
        actions: [
          FilledButton.tonal(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.accept),
          ),
        ],
      ),
    );

    if (confirmed != true) return;
    if (!context.mounted) return;

    // 2. Elegir tiempo del siguiente ciclo
    final result = await showModalBottomSheet<(int, bool)>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => _NextCycleTimeSheet(
        type: type,
        title: l10n.harvestNextStepTitle,
      ),
    );

    if (result == null) return;
    final (durationSeconds, isOpenEnded) = result;

    // 3. Ejecutar
    final notifTitle = type == FermentationType.kombucha
        ? l10n.notifReadyTitleKombucha
        : l10n.notifReadyTitleKefir;

    ref.read(activeFermentationsProvider.notifier).harvestAndRestart(
          id,
          nextDurationSeconds: durationSeconds,
          nextIsOpenEnded: isOpenEnded,
          notifReadyTitle: notifTitle,
          notifReadyBody: l10n.notifReadyBodyGeneric,
          notifReminderTitle: l10n.notifReminderTitleGeneric,
          notifReminderBody: l10n.notifReminderBodyGeneric,
        );

    if (context.mounted) {
      Navigator.pop(context);
    }
  }
}

class _NextCycleTimeSheet extends ConsumerWidget {
  final FermentationType type;
  final String title;

  const _NextCycleTimeSheet({
    required this.type,
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0).copyWith(
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            // Ideal Duration if exists
            FutureBuilder<Duration?>(
              future: type == FermentationType.kefir
                  ? ref.read(fermentationServiceProvider).getKefirIdealDuration()
                  : ref
                      .read(fermentationServiceProvider)
                      .getKombuchaIdealDuration(),
              builder: (ctx, snapshot) {
                final ideal = snapshot.data;
                if (ideal == null) return const SizedBox.shrink();

                final days = (ideal.inSeconds / 86400).toStringAsFixed(1);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: FilledButton.icon(
                    onPressed: () => Navigator.pop(context, (ideal.inSeconds, false)),
                    icon: const Icon(Icons.star_rounded),
                    label: Text(l10n.addSheetIdealTime(num.parse(days))),
                  ),
                );
              },
            ),
            // Custom Time
            FilledButton.tonalIcon(
              onPressed: () => CustomDurationPicker.show(
                context,
                type: type,
                onConfirm: (duration) => Navigator.pop(context, (duration.inSeconds, false)),
              ),
              icon: const Icon(Icons.tune_rounded),
              label: Text(l10n.addSheetCustomTime),
            ),
            const SizedBox(height: 12),
            // No Limit
            FilledButton.tonalIcon(
              onPressed: () => Navigator.pop(context, (0, true)),
              icon: const Icon(Icons.all_inclusive_rounded),
              label: Text(l10n.addSheetNoLimit),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
