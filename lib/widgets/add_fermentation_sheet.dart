import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/fermentation.dart';
import '../providers/fermentation_provider.dart';
import '../providers/service_providers.dart';
import '../widgets/custom_duration_picker.dart';
import 'package:kefir_control/l10n/app_localizations.dart';

class AddFermentationSheet extends ConsumerStatefulWidget {
  const AddFermentationSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => const AddFermentationSheet(),
    );
  }

  @override
  ConsumerState<AddFermentationSheet> createState() =>
      _AddFermentationSheetState();
}

class _AddFermentationSheetState extends ConsumerState<AddFermentationSheet> {
  FermentationType? _selectedType;
  DateTime? _customStartDate;

  Future<void> _pickStartDate() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now(),
      cancelText: 'Cancelar',
      confirmText: 'Aceptar',
    );
    if (date == null) return;
    if (!mounted) return;

    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      cancelText: 'Cancelar',
      confirmText: 'Aceptar',
    );
    if (time == null) return;

    setState(() {
      _customStartDate = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  Future<void> _start(int durationSeconds) async {
    final l10n = AppLocalizations.of(context)!;
    Navigator.pop(context);
    final l10nTitle = _selectedType == FermentationType.kombucha
        ? l10n.notifReadyTitleKombucha
        : l10n.notifReadyTitleKefir;
    final l10nBody = l10n.notifReadyBodyGeneric;
    final l10nRemTitle = l10n.notifReminderTitleGeneric;
    final l10nRemBody = l10n.notifReminderBodyGeneric;

    ref.read(activeFermentationsProvider.notifier).start(
          durationSeconds,
          type: _selectedType!,
          customStartTime: _customStartDate,
          notifReadyTitle: l10nTitle,
          notifReadyBody: l10nBody,
          notifReminderTitle: l10nRemTitle,
          notifReminderBody: l10nRemBody,
        );
  }

  Future<void> _startOpenEnded() async {
    final l10n = AppLocalizations.of(context)!;
    Navigator.pop(context);
    final l10nTitle = _selectedType == FermentationType.kombucha
        ? l10n.notifReadyTitleKombucha
        : l10n.notifReadyTitleKefir;
    final l10nBody = l10n.notifReadyBodyGeneric;
    final l10nRemTitle = l10n.notifReminderTitleGeneric;
    final l10nRemBody = l10n.notifReminderBodyGeneric;

    ref.read(activeFermentationsProvider.notifier).start(
          0,
          type: _selectedType!,
          customStartTime: _customStartDate,
          isOpenEnded: true,
          notifReadyTitle: l10nTitle,
          notifReadyBody: l10nBody,
          notifReminderTitle: l10nRemTitle,
          notifReminderBody: l10nRemBody,
        );
  }

  Widget _buildTypeSelection() {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.addSheetTitle,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        OutlinedButton.icon(
          onPressed: () =>
              setState(() => _selectedType = FermentationType.kefir),
          icon: const Icon(Icons.local_drink),
          label: Text(l10n.addSheetKefir),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 20),
            textStyle: const TextStyle(fontSize: 18),
          ),
        ),
        const SizedBox(height: 16),
        OutlinedButton.icon(
          onPressed: () =>
              setState(() => _selectedType = FermentationType.kombucha),
          icon: const Icon(Icons.emoji_food_beverage),
          label: Text(l10n.addSheetKombucha),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 20),
            textStyle: const TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BackButton(onPressed: () => setState(() => _selectedType = null)),
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 48),
      ],
    );
  }

  Widget _buildPastDateSelector() {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _customStartDate == null
            ? SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  key: const ValueKey('button'),
                  onPressed: _pickStartDate,
                  icon: const Icon(Icons.history),
                  label: Text(l10n.addSheetPastRecord),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              )
            : Container(
                key: const ValueKey('text'),
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle,
                        color: Theme.of(context).colorScheme.primary),
                    const SizedBox(width: 8),
                    Text(
                      l10n.addSheetPastSelected(
                          '${_customStartDate!.day}/${_customStartDate!.month} ${_customStartDate!.hour}:${_customStartDate!.minute.toString().padLeft(2, '0')}'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onPrimaryContainer,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  /// Botón "Sin límite", compartido por kéfir y kombucha.
  Widget _buildNoLimitButton(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: FilledButton.tonalIcon(
        onPressed: _startOpenEnded,
        icon: const Icon(Icons.all_inclusive),
        label: Text(l10n.addSheetNoLimit),
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  /// Botón "Tiempo personalizado", abre el picker.
  Widget _buildCustomTimeButton(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: FilledButton.tonalIcon(
        onPressed: () => CustomDurationPicker.show(
          context,
          type: _selectedType!,
          onConfirm: (duration) => _start(duration.inSeconds),
        ),
        icon: const Icon(Icons.tune),
        label: Text(l10n.addSheetCustomTime),
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  Widget _buildKefirSelection() {
    final l10n = AppLocalizations.of(context)!;
    return FutureBuilder<Duration?>(
      future: ref.read(fermentationServiceProvider).getKefirIdealDuration(),
      builder: (context, snapshot) {
        final idealSecs = snapshot.data?.inSeconds;
        final idealHours = snapshot.data != null
            ? (snapshot.data!.inMinutes / 60.0)
            : null;
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(l10n.addSheetTimeKefir),
            const SizedBox(height: 16),
            // Botón favorito (solo aparece si ya hay un tiempo ideal guardado)
            if (idealSecs != null && idealHours != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: FilledButton(
                  onPressed: () => _start(idealSecs),
                  style: FilledButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.primary,
                  ),
                  child: Text(l10n.addSheetIdealTimeKefir(
                      num.parse(idealHours.toStringAsFixed(1)))),
                ),
              ),
            // Tiempo personalizado
            _buildCustomTimeButton(l10n),
            // Sin límite
            _buildNoLimitButton(l10n),
            // Fecha pasada
            _buildPastDateSelector(),
          ],
        );
      },
    );
  }

  Widget _buildKombuchaSelection() {
    final l10n = AppLocalizations.of(context)!;
    return FutureBuilder<Duration?>(
      future: ref.read(fermentationServiceProvider).getKombuchaIdealDuration(),
      builder: (context, snapshot) {
        final idealSecs = snapshot.data?.inSeconds;
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(l10n.addSheetTimeKombucha),
            const SizedBox(height: 16),
            // Botón favorito kombucha
            if (idealSecs != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: FilledButton(
                  onPressed: () => _start(idealSecs),
                  style: FilledButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.primary,
                  ),
                  child: Text(l10n.addSheetIdealTime(
                      num.parse((idealSecs / 86400).toStringAsFixed(1)))),
                ),
              ),
            // Tiempo personalizado
            _buildCustomTimeButton(l10n),
            // Sin límite
            _buildNoLimitButton(l10n),
            // Fecha pasada
            _buildPastDateSelector(),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: _selectedType == null
            ? _buildTypeSelection()
            : _selectedType == FermentationType.kefir
                ? _buildKefirSelection()
                : _buildKombuchaSelection(),
      ),
    );
  }
}
