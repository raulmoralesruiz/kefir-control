import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kefir_control/l10n/app_localizations.dart';
import '../models/fermentation_history_item.dart';
import '../providers/history_provider.dart';
import '../widgets/history_list_item.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});



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
              return HistoryListItem(
                item: item,
                onDismissed: () => _deleteItem(context, ref, item),
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
