import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/add_fermentation_sheet.dart';
import '../widgets/fermentation_card.dart';
import '../models/fermentation.dart';
import 'info_screen.dart';
import 'history_screen.dart';
import 'calendar_screen.dart';
import 'package:kefir_control/l10n/app_localizations.dart';
import '../providers/fermentation_provider.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../providers/locale_provider.dart';
import '../providers/history_provider.dart';
import '../providers/service_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void _showAddSheet(BuildContext context) {
    AddFermentationSheet.show(context);
  }

  void _onStopSelected(
      BuildContext context, WidgetRef ref, Fermentation fermentation) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.homeStopTitle),
        content: Text(l10n
            .homeStopContent), // We might need to update these translations later
        actions: [
          FilledButton.tonal(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
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
      ref.read(activeFermentationsProvider.notifier).stop(fermentation.id);
    }
  }

  void _onHarvestKombucha(
      BuildContext context, WidgetRef ref, Fermentation fermentation) async {
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
                  .stop(fermentation.id, recordHistory: true);
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
      ref.read(activeFermentationsProvider.notifier).stop(fermentation.id,
          recordHistory: true, customIdealTime: fermentation.elapsed);
    }
  }

  Future<void> _exportBackup(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    try {
      final jsonString = await ref.read(fermentationServiceProvider).exportData();
      final directory = await getTemporaryDirectory();
      final path = '${directory.path}/kefir_backup.json';
      final file = File(path);
      await file.writeAsString(jsonString);
      
      final xfile = XFile(path);
      await SharePlus.instance.share(ShareParams(files: [xfile], text: 'Backup de Kefir Control'));
      if (context.mounted) {
        showDialog(context: context, builder: (ctx) => AlertDialog(
          title: Text(l10n.backupSuccessTitle),
          content: Text(l10n.backupSuccessDesc),
          actions: [
            FilledButton.tonal(onPressed: () => Navigator.pop(ctx), child: Text(l10n.accept))
          ]
        ));
      }
    } catch (e) {
      // Ignorar o loguear
    }
  }

  Future<void> _importBackup(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );
      if (result != null && result.files.single.path != null) {
        final file = File(result.files.single.path!);
        final jsonString = await file.readAsString();
        final success = await ref.read(fermentationServiceProvider).importData(jsonString);
        if (context.mounted) {
          if (success) {
            ref.invalidate(activeFermentationsProvider);
            ref.invalidate(historyProvider);
            showDialog(context: context, builder: (ctx) => AlertDialog(
              title: Text(l10n.restoreSuccessTitle),
              content: Text(l10n.restoreSuccessDesc),
              actions: [
                FilledButton.tonal(onPressed: () => Navigator.pop(ctx), child: Text(l10n.accept))
              ]
            ));
          } else {
            showDialog(context: context, builder: (ctx) => AlertDialog(
              title: Text(l10n.restoreErrorTitle),
              content: Text(l10n.restoreErrorDesc),
              actions: [
                FilledButton.tonal(onPressed: () => Navigator.pop(ctx), child: Text(l10n.accept))
              ]
            ));
          }
        }
      }
    } catch (e) {
      if (context.mounted) {
        showDialog(context: context, builder: (ctx) => AlertDialog(
          title: Text(l10n.restoreErrorTitle),
          content: Text(l10n.restoreErrorDesc),
          actions: [
            FilledButton.tonal(onPressed: () => Navigator.pop(ctx), child: Text(l10n.accept))
          ]
        ));
      }
    }
  }

  Widget _buildDrawer(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isEnglish = Localizations.localeOf(context).languageCode == 'en';
    final colorScheme = Theme.of(context).colorScheme;

    return NavigationDrawer(
      onDestinationSelected: (index) async {
        Navigator.pop(context);
        switch (index) {
          case 0:
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const HistoryScreen()));
          case 1:
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const InfoScreen()));
          case 2:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const CalendarScreen()));
          case 3:
            await _exportBackup(context, ref);
          case 4:
            await _importBackup(context, ref);
          case 5:
            final url = Uri.parse('https://paypal.me/raulmoralesruiz');
            if (await canLaunchUrl(url)) {
              await launchUrl(url, mode: LaunchMode.externalApplication);
            }
        }
      },
      selectedIndex: null,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.local_drink, size: 40, color: colorScheme.primary),
              const SizedBox(height: 12),
              Text(
                l10n.appTitle,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                l10n.devDesc,
                style: TextStyle(
                  fontSize: 12,
                  color: colorScheme.onPrimaryContainer.withAlpha(180),
                ),
              ),
            ],
          ),
        ),
        // Switch de idioma: shape y padding igualados al NavigationDrawerDestination
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: SwitchListTile(
            secondary: Icon(
              isEnglish ? Icons.language : Icons.language,
              color: colorScheme.onSurfaceVariant,
            ),
            title: Text(l10n.changeLanguage),
            subtitle: Text(isEnglish ? 'English' : 'Español'),
            value: isEnglish,
            onChanged: (_) {
              ref.read(localeProvider.notifier).setLocale(
                  isEnglish ? const Locale('es') : const Locale('en'));
            },
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
          ),
        ),
        const Divider(indent: 16, endIndent: 16, height: 24),
        NavigationDrawerDestination(
          icon: const Icon(Icons.history_outlined),
          selectedIcon: const Icon(Icons.history),
          label: Text(l10n.history),
        ),
        NavigationDrawerDestination(
          icon: const Icon(Icons.info_outline),
          selectedIcon: const Icon(Icons.info),
          label: Text(l10n.infoTitle),
        ),
        NavigationDrawerDestination(
          icon: const Icon(Icons.calendar_month_outlined),
          selectedIcon: const Icon(Icons.calendar_month),
          label: Text(l10n.drawerCalendar),
        ),
        const Divider(indent: 16, endIndent: 16, height: 24),
        NavigationDrawerDestination(
          icon: const Icon(Icons.upload_file_outlined),
          selectedIcon: const Icon(Icons.upload_file),
          label: Text(l10n.drawerBackup),
        ),
        NavigationDrawerDestination(
          icon: const Icon(Icons.download_outlined),
          selectedIcon: const Icon(Icons.download),
          label: Text(l10n.drawerRestore),
        ),
        const Divider(indent: 16, endIndent: 16, height: 24),
        NavigationDrawerDestination(
          icon: const Icon(Icons.coffee_outlined),
          selectedIcon: const Icon(Icons.coffee),
          label: Text(l10n.drawerDonate),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final fermentations = ref.watch(activeFermentationsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        centerTitle: true,
      ),
      drawer: _buildDrawer(context, ref),
      body: fermentations.isEmpty
          ? Center(
              child: Text(
                l10n.homeNoActiveFermentationTitle,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16).copyWith(bottom: 100),
              itemCount: fermentations.length,
              itemBuilder: (context, index) {
                final fermentation = fermentations[index];
                return Dismissible(
                  key: Key(fermentation.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    color: Theme.of(context).colorScheme.error,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Icon(Icons.delete,
                        color: Theme.of(context).colorScheme.onError),
                  ),
                  confirmDismiss: (direction) async {
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(l10n.homeDeleteTitle),
                        content: Text(l10n.homeDeleteDesc),
                        actions: [
                          FilledButton.tonal(
                            onPressed: () => Navigator.pop(context, false),
                            child: Text(l10n.cancel),
                          ),
                          FilledButton(
                            onPressed: () => Navigator.pop(context, true),
                            style: FilledButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.error,
                              foregroundColor:
                                  Theme.of(context).colorScheme.onError,
                            ),
                            child: Text(l10n.homeDeleteBtn),
                          ),
                        ],
                      ),
                    );
                    return confirmed;
                  },
                  onDismissed: (direction) {
                    ref
                        .read(activeFermentationsProvider.notifier)
                        .stop(fermentation.id, recordHistory: false);
                  },
                  child: FermentationCard(
                    fermentation: fermentation,
                    onStop: () => _onStopSelected(context, ref, fermentation),
                    onHarvest: () =>
                        _onHarvestKombucha(context, ref, fermentation),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddSheet(context),
        icon: const Icon(Icons.add),
        label: Text(l10n.homeNewFermentation),
      ),
    );
  }
}
