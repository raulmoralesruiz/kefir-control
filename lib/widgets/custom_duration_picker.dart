import 'package:flutter/material.dart';
import '../models/fermentation.dart';
import 'package:kefir_control/l10n/app_localizations.dart';
import '../services/haptic_service.dart';

const _kombuchaColor = Color(0xFFF59E0B);

/// Picker de duración personalizada con ruedas tipo scrollable.
/// - Modo kéfir: solo horas (1–72h).
/// - Modo kombucha: días (1–30) + horas (0–23).
///
/// Retorna un [Duration] a través del [onConfirm] callback.
class CustomDurationPicker extends StatefulWidget {
  final FermentationType type;
  final void Function(Duration duration) onConfirm;

  const CustomDurationPicker({
    super.key,
    required this.type,
    required this.onConfirm,
  });

  /// Muestra el picker en un BottomSheet modal y retorna la [Duration] elegida,
  /// o null si el usuario cancela.
  static Future<void> show(
    BuildContext context, {
    required FermentationType type,
    required void Function(Duration) onConfirm,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => CustomDurationPicker(type: type, onConfirm: onConfirm),
    );
  }

  @override
  State<CustomDurationPicker> createState() => _CustomDurationPickerState();
}

class _CustomDurationPickerState extends State<CustomDurationPicker> {
  late int _selectedHours;
  late int _selectedDays;

  late FixedExtentScrollController _hoursController;
  late FixedExtentScrollController _daysController;

  bool get _isKombucha => widget.type == FermentationType.kombucha;

  /// Horas disponibles: kéfir → 1..72, kombucha → 0..23
  List<int> get _hourOptions =>
      _isKombucha ? List.generate(24, (i) => i) : List.generate(72, (i) => i + 1);

  /// Días disponibles: solo kombucha → 1..30
  List<int> get _dayOptions => List.generate(30, (i) => i + 1);

  @override
  void initState() {
    super.initState();
    _selectedHours = _isKombucha ? 0 : 24;
    _selectedDays = 7;

    _hoursController = FixedExtentScrollController(
      initialItem: _hourOptions.indexOf(_selectedHours),
    );
    _daysController = FixedExtentScrollController(
      initialItem: _dayOptions.indexOf(_selectedDays),
    );
  }

  @override
  void dispose() {
    _hoursController.dispose();
    _daysController.dispose();
    super.dispose();
  }

  Duration get _currentDuration {
    if (_isKombucha) {
      return Duration(days: _selectedDays, hours: _selectedHours);
    }
    return Duration(hours: _selectedHours);
  }

  Widget _buildWheel({
    required List<int> items,
    required int selectedValue,
    required FixedExtentScrollController controller,
    required String label,
    required void Function(int) onChanged,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurfaceVariant,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 160,
          width: 100,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Líneas de selección
              Container(
                height: 48,
                decoration: BoxDecoration(
                  color: (_isKombucha ? _kombuchaColor : colorScheme.primaryContainer)
                      .withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              ListWheelScrollView.useDelegate(
                controller: controller,
                itemExtent: 48,
                perspective: 0.003,
                diameterRatio: 2.0,
                physics: const FixedExtentScrollPhysics(),
                onSelectedItemChanged: (index) {
                  HapticService.selection();
                  onChanged(items[index]);
                },
                childDelegate: ListWheelChildBuilderDelegate(
                  childCount: items.length,
                  builder: (context, index) {
                    final value = items[index];
                    final isSelected = value == selectedValue;
                    return Center(
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: TextStyle(
                          fontSize: isSelected ? 28 : 20,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: isSelected
                              ? (_isKombucha ? _kombuchaColor : colorScheme.primary)
                              : colorScheme.onSurfaceVariant,
                        ),
                        child: Text(value.toString().padLeft(2, '0')),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.addSheetCustomTime,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_isKombucha) ...[
                  _buildWheel(
                    items: _dayOptions,
                    selectedValue: _selectedDays,
                    controller: _daysController,
                    label: l10n.addSheetCustomDays.toUpperCase(),
                    onChanged: (v) => setState(() => _selectedDays = v),
                  ),
                  const SizedBox(width: 24),
                ],
                _buildWheel(
                  items: _hourOptions,
                  selectedValue: _selectedHours,
                  controller: _hoursController,
                  label: l10n.addSheetCustomHours.toUpperCase(),
                  onChanged: (v) => setState(() => _selectedHours = v),
                ),
              ],
            ),
            const SizedBox(height: 32),
            FilledButton(
              onPressed: () {
                final duration = _currentDuration;
                // Validar que hay al menos 1 hora de duración
                if (duration.inHours < 1) return;
                HapticService.medium();
                Navigator.pop(context);
                widget.onConfirm(duration);
              },
              style: FilledButton.styleFrom(
                backgroundColor: _isKombucha ? _kombuchaColor : colorScheme.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                l10n.addSheetCustomConfirm,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
