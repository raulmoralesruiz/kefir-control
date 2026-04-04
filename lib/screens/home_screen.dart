import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/manual_start_dialog.dart';
import '../widgets/time_progress.dart';
import 'info_screen.dart';
import 'history_screen.dart';
import 'package:kefir_control/l10n/app_localizations.dart';
import '../providers/fermentation_provider.dart';
import '../providers/locale_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void _startFermentation(BuildContext context, WidgetRef ref, int hours, {DateTime? customStartTime}) async {
    final l10n = AppLocalizations.of(context)!;
    ref.read(activeFermentationProvider.notifier).start(
      hours,
      customStartTime: customStartTime,
      notifReadyTitle: l10n.notifReadyTitle,
      notifReadyBody: l10n.notifReadyBody(hours.toString()),
      notifReminderTitle: l10n.notifReminderTitle,
      notifReminderBody: l10n.notifReminderBody,
    );
  }

  Future<void> _showStartDialog(BuildContext context, WidgetRef ref, {required bool askForDate}) async {
    final result = await ManualStartDialog.show(context, askForDate: askForDate);
    if (result != null) {
      _startFermentation(context, ref, result.hours, customStartTime: result.customStartTime);
    }
  }

  void _showStartBottomSheet(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                FilledButton.icon(
                  onPressed: () {
                    Navigator.pop(ctx);
                    _showStartDialog(context, ref, askForDate: false);
                  },
                  icon: const Icon(Icons.play_circle_fill),
                  label: Text(l10n.btnStartFermentation),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(ctx);
                    _showStartDialog(context, ref, askForDate: true);
                  },
                  icon: const Icon(Icons.history),
                  label: Text(l10n.btnStartPastFermentation),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _stopFermentation(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.homeStopTitle),
        content: Text(AppLocalizations.of(context)!.homeStopContent),
        actions: [
          FilledButton.tonal(
            onPressed: () => Navigator.pop(context, false),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
            child: Text(AppLocalizations.of(context)!.homeStopConfirm),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    await ref.read(activeFermentationProvider.notifier).stop();
  }

  Widget _buildDrawer(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isEnglish = Localizations.localeOf(context).languageCode == 'en';
    final colorScheme = Theme.of(context).colorScheme;

    return NavigationDrawer(
      onDestinationSelected: (index) {
        Navigator.pop(context); // cierra el drawer
        if (index == 0) {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const HistoryScreen()));
        } else if (index == 1) {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const InfoScreen()));
        }
      },
      selectedIndex: null, // ninguno seleccionado (estamos en Home)
      children: [
        // ── Header ────────────────────────────────────────────────────────────
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

        // ── Toggle de idioma ───────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: SwitchListTile(
            secondary: const Icon(Icons.language),
            title: Text(l10n.changeLanguage),
            subtitle: Text(isEnglish ? 'English' : 'Español'),
            value: isEnglish,
            onChanged: (_) {
              ref.read(localeProvider.notifier).setLocale(
                  isEnglish ? const Locale('es') : const Locale('en'));
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),

        const Divider(indent: 16, endIndent: 16, height: 24),

        // ── Destinos ───────────────────────────────────────────────────────
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

        const Divider(indent: 16, endIndent: 16, height: 24),

        // ── Donación ───────────────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: ListTile(
            leading: const Icon(Icons.coffee_outlined),
            title: Text(l10n.drawerDonate),
            subtitle: Text(l10n.drawerDonateSubtitle),
            onTap: () async {
              Navigator.pop(context);
              final url = Uri.parse('https://paypal.me/raulmoralesruiz');
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              }
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final fermentation = ref.watch(activeFermentationProvider);
    final hasFermentation = fermentation != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        centerTitle: true,
      ),
      drawer: _buildDrawer(context, ref),
      body: SafeArea(
        child: hasFermentation
            ? TimeProgress(fermentation: fermentation)
            : Center(
                child: Text(
                  l10n.homeNoActiveFermentationTitle,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: hasFermentation ? () => _stopFermentation(context, ref) : () => _showStartBottomSheet(context, ref),
        icon: Icon(hasFermentation
            ? Icons.stop_circle_outlined
            : Icons.play_circle_fill),
        label: Text(
          hasFermentation
              ? l10n.btnStopFermentation
              : l10n.btnStartFermentation,
        ),
        backgroundColor: hasFermentation
            ? Theme.of(context).colorScheme.error
            : Theme.of(context).colorScheme.primary,
        foregroundColor: hasFermentation
            ? Theme.of(context).colorScheme.onError
            : Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}
