import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/fermentation.dart';
import '../models/fermentation_history_item.dart';
import '../services/fermentation_service.dart';
import '../services/notification_service.dart';
import '../widgets/manual_start_dialog.dart';
import '../widgets/time_progress.dart';
import 'info_screen.dart';
import 'history_screen.dart';
import 'package:kefir_control/l10n/app_localizations.dart';
import 'package:kefir_control/main.dart' show appLocaleNotifier;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FermentationService _service = FermentationService();
  final NotificationService _notificationService = NotificationService();

  Fermentation? _fermentation;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _initNotifications();
    _loadData();
  }

  Future<void> _initNotifications() async {
    await _notificationService.init();
  }

  Future<void> _loadData() async {
    final saved = await _service.loadFermentation();
    if (saved != null) {
      setState(() {
        _fermentation = saved;
      });
      _startTimer();
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
      if (_fermentation != null && _fermentation!.progress >= 1.0) {
        _timer?.cancel();
      }
    });
  }

  void _startFermentation(int hours, {DateTime? customStartTime}) async {
    final startTime = customStartTime ?? DateTime.now();
    final targetDuration = Duration(hours: hours);
    final newFermentation = Fermentation(
      startTime: startTime,
      targetDuration: targetDuration,
    );
    await _service.saveFermentation(newFermentation);
    setState(() {
      _fermentation = newFermentation;
    });
    _startTimer();

    final l10n = AppLocalizations.of(context)!;
    await _notificationService.cancelAll();
    await _notificationService.scheduleFermentationComplete(
      startTime.add(targetDuration),
      l10n.notifReadyTitle,
      l10n.notifReadyBody(hours.toString()),
      l10n.notifReminderTitle,
      l10n.notifReminderBody,
    );
  }

  Future<void> _showStartDialog({required bool askForDate}) async {
    final result =
        await ManualStartDialog.show(context, askForDate: askForDate);
    if (result != null) {
      _startFermentation(result.hours, customStartTime: result.customStartTime);
    }
  }

  void _showStartBottomSheet() {
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
                    _showStartDialog(askForDate: false);
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
                    _showStartDialog(askForDate: true);
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

  void _stopFermentation() async {
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

    if (_fermentation != null) {
      final now = DateTime.now();
      final isSuccess = now.isAfter(
              _fermentation!.startTime.add(_fermentation!.targetDuration)) ||
          now.isAtSameMomentAs(
              _fermentation!.startTime.add(_fermentation!.targetDuration));
      final historyItem = FermentationHistoryItem(
        startTime: _fermentation!.startTime,
        targetDuration: _fermentation!.targetDuration,
        completedAt: now,
        isSuccess: isSuccess,
      );
      await _service.addHistoryEntry(historyItem);
    }

    await _service.clearFermentation();
    _timer?.cancel();
    await _notificationService.cancelAll();
    setState(() {
      _fermentation = null;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Widget _buildDrawer(BuildContext context) {
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
              appLocaleNotifier.value =
                  isEnglish ? const Locale('es') : const Locale('en');
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
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final hasFermentation = _fermentation != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        centerTitle: true,
        // El icono ☰ aparece automáticamente al definir `drawer`
      ),
      drawer: _buildDrawer(context),
      body: SafeArea(
        child: hasFermentation
            ? TimeProgress(fermentation: _fermentation!)
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
        onPressed: hasFermentation ? _stopFermentation : _showStartBottomSheet,
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
