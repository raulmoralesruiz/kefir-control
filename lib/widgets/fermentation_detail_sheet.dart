import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kefir_control/l10n/app_localizations.dart';
import '../models/fermentation.dart';
import '../models/fermentation_history_item.dart';
import '../providers/fermentation_provider.dart';
import '../providers/history_provider.dart';

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
    
    final type = isHistory ? widget.historyItem!.type : widget.fermentation!.type;
    final fermentationName = isHistory ? widget.historyItem!.name : widget.fermentation!.name;
    final isKombucha = type == FermentationType.kombucha;
    final typeColor = isKombucha ? _kombuchaColor : colorScheme.primary;

    // Lógica específica según modo
    final bool isOpenEnded;
    final bool isPlanned;
    final String stageText;

    if (isHistory) {
      isOpenEnded = widget.historyItem!.isOpenEnded;
      isPlanned = false;
      // Para el historial, la "etapa" es simplemente que está completada
      stageText = l10n.historyCompletedOn(_formatDateTime(widget.historyItem!.completedAt));
    } else {
      isOpenEnded = widget.fermentation!.isOpenEnded;
      isPlanned = widget.fermentation!.elapsed.isNegative;
      stageText = isPlanned ? l10n.calendarPlannedBadge : widget.fermentation!.getStageLocalized(l10n);
    }

    final displayTitle = fermentationName?.isNotEmpty == true
        ? fermentationName!
        : (isKombucha ? l10n.addSheetKombucha : l10n.addSheetKefir);

    return Container(
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
                ],
              ),
              const SizedBox(height: 24),
              
              // Descripción de etapa (Solo para activas no planificadas)
              if (!isHistory && !isPlanned)
                _StageDescriptionCard(
                  fermentation: widget.fermentation!,
                  l10n: l10n,
                  typeColor: typeColor,
                  colorScheme: colorScheme,
                ),
              if (!isHistory && !isPlanned) const SizedBox(height: 24),
              
              // Progreso (Si es historial, mostramos 100% o nada)
              _ProgressSection(
                fermentation: widget.fermentation,
                historyItem: widget.historyItem,
                typeColor: typeColor,
                colorScheme: colorScheme,
                isPlanned: isPlanned,
                isOpenEnded: isOpenEnded,
              ),
              const SizedBox(height: 24),
              
              // Grid de tiempos adaptado
              _TimeDataGrid(
                fermentation: widget.fermentation,
                historyItem: widget.historyItem,
                l10n: l10n,
                isPlanned: isPlanned,
                isOpenEnded: isOpenEnded,
                colorScheme: colorScheme,
                formatDuration: _formatDuration,
                formatDateTime: _formatDateTime,
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
                FilledButton.icon(
                  onPressed: isKombucha ? widget.onHarvest : widget.onStop,
                  icon: const Icon(Icons.stop_circle_outlined),
                  label: Text(isKombucha ? l10n.cardCosechar : l10n.cardFinalizar),
                  style: FilledButton.styleFrom(
                    backgroundColor: colorScheme.error,
                    foregroundColor: colorScheme.onError,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              const SizedBox(height: 40),
            ],
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
              ? LinearProgressIndicator(
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  minHeight: 16,
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
