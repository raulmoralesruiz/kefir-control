import 'package:flutter/material.dart';

class ManualStartResult {
  final int hours;
  final DateTime customStartTime;

  ManualStartResult({required this.hours, required this.customStartTime});
}

class ManualStartDialog {
  static Future<ManualStartResult?> show(BuildContext context) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 7)),
      lastDate: DateTime.now(),
    );
    if (date == null) return null;

    if (!context.mounted) return null;
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time == null) return null;

    final customDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    int selectedHours = 24;

    if (!context.mounted) return null;

    return await showDialog<ManualStartResult>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Selecciona la duración'),
              content: RadioGroup<int>(
                groupValue: selectedHours,
                onChanged: (val) => setState(() => selectedHours = val!),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RadioListTile<int>(
                      title: Text('24 horas'),
                      value: 24,
                    ),
                    RadioListTile<int>(
                      title: Text('36 horas'),
                      value: 36,
                    ),
                    RadioListTile<int>(
                      title: Text('48 horas'),
                      value: 48,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      ManualStartResult(
                        hours: selectedHours,
                        customStartTime: customDateTime,
                      ),
                    );
                  },
                  child: const Text('Iniciar'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
