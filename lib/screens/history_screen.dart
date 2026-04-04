import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kefir_control/l10n/app_localizations.dart';
import '../models/fermentation.dart';
import '../models/fermentation_history_item.dart';
import '../providers/history_provider.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  String _formatDateTime(DateTime dt) {
    final day = dt.day.toString().padLeft(2, '0');
    final month = dt.month.toString().padLeft(2, '0');
    final year = dt.year;
    final hour = dt.hour.toString().padLeft(2, '0');
    final minute = dt.minute.toString().padLeft(2, '0');
    return '$day/$month/$year $hour:$minute';
  }

  Future<void> _clearHistory(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.historyClearTitle),
        content: Text(AppLocalizations.of(context)!.historyClearContent),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
            child: Text(AppLocalizations.of(context)!.historyClearConfirm),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(historyProvider.notifier).clearHistory();
    }
  }

  Future<void> _deleteItem(BuildContext context, WidgetRef ref, FermentationHistoryItem item) async {
    await ref.read(historyProvider.notifier).deleteEntry(item.completedAt);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.historyDeleted)),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(historyProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.historyTitle),
        centerTitle: true,
      ),
      body: historyAsync.when(
        data: (history) {
          if (history.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  AppLocalizations.of(context)!.historyEmpty,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            );
          }

          return ListView.builder(
            itemCount: history.length,
            itemBuilder: (context, index) {
              final item = history[index];
              final isSuccess = item.isSuccess;
              final isKombucha = item.type == FermentationType.kombucha;

              return Dismissible(
                key: Key(item.completedAt.millisecondsSinceEpoch.toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  color: Colors.red,
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) {
                  _deleteItem(context, ref, item);
                },
                child: Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 0,
                  child: ListTile(
                    leading: Badge(
                      isLabelVisible: !isSuccess,
                      label: const Icon(Icons.cancel, size: 10, color: Colors.white),
                      backgroundColor: Colors.orange,
                      offset: const Offset(4, 4),
                      child: CircleAvatar(
                        backgroundColor: isSuccess
                            ? Colors.green.withOpacity(0.2)
                            : Colors.orange.withOpacity(0.2),
                        child: Icon(
                          isKombucha ? Icons.coffee_outlined : Icons.local_drink,
                          color: isSuccess ? Colors.green : Colors.orange,
                        ),
                      ),
                    ),
                    title: Text(
                      isKombucha ? AppLocalizations.of(context)!.historyKombuchaFinished : AppLocalizations.of(context)!.historyItemTitle(item.targetDuration.inHours),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(AppLocalizations.of(context)!.historyItemStart(_formatDateTime(item.startTime))),
                        Text(AppLocalizations.of(context)!.historyItemEnd(_formatDateTime(item.completedAt))),
                        if (isKombucha) 
                          Text(AppLocalizations.of(context)!.historyKombuchaDuration(num.parse((item.targetDuration.inHours / 24).toStringAsFixed(1)))),
                      ],
                    ),
                    isThreeLine: true,
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: historyAsync.maybeWhen(
        data: (history) {
          if (history.isEmpty) return const SizedBox.shrink();
          return FloatingActionButton.extended(
            onPressed: () => _clearHistory(context, ref),
            icon: const Icon(Icons.delete_sweep),
            label: Text(AppLocalizations.of(context)!.historyClear),
            backgroundColor: Theme.of(context).colorScheme.error,
            foregroundColor: Theme.of(context).colorScheme.onError,
          );
        },
        orElse: () => const SizedBox.shrink(),
      ),
    );
  }
}
