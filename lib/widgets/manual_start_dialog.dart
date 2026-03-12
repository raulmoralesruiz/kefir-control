import 'package:flutter/material.dart';
import 'package:kefir_control/l10n/app_localizations.dart';

class ManualStartResult {
  final int hours;
  final DateTime customStartTime;

  ManualStartResult({required this.hours, required this.customStartTime});
}

class ManualStartDialog {
  static Future<ManualStartResult?> show(BuildContext context,
      {bool askForDate = true}) async {
    DateTime customDateTime = DateTime.now();

    if (askForDate) {
      final DateTime? date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(const Duration(days: 7)),
        lastDate: DateTime.now(),
        cancelText: AppLocalizations.of(context)!.cancel,
        confirmText: AppLocalizations.of(context)!.accept,
      );
      if (date == null) return null;

      if (!context.mounted) return null;
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        cancelText: AppLocalizations.of(context)!.cancel,
        confirmText: AppLocalizations.of(context)!.accept,
      );
      if (time == null) return null;

      customDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    }

    int selectedHours = 24;

    if (!context.mounted) return null;

    return await showDialog<ManualStartResult>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(AppLocalizations.of(context)!.dialogManualDuration),
              content: RadioGroup<int>(
                groupValue: selectedHours,
                onChanged: (val) => setState(() => selectedHours = val!),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RadioListTile<int>(
                      title: Text(AppLocalizations.of(context)!.dialogOption24h),
                      value: 24,
                    ),
                    RadioListTile<int>(
                      title: Text(AppLocalizations.of(context)!.dialogOption36h),
                      value: 36,
                    ),
                    RadioListTile<int>(
                      title: Text(AppLocalizations.of(context)!.dialogOption48h),
                      value: 48,
                    ),
                  ],
                ),
              ),
              actions: [
                FilledButton.tonal(
                  onPressed: () => Navigator.pop(context),
                  child: Text(AppLocalizations.of(context)!.cancel),
                ),
                FilledButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      ManualStartResult(
                        hours: selectedHours,
                        customStartTime: customDateTime,
                      ),
                    );
                  },
                  child: Text(AppLocalizations.of(context)!.dialogManualBtnStart),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
