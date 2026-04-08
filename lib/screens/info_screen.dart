import 'package:flutter/material.dart';
import 'package:kefir_control/l10n/app_localizations.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.infoTitle),
          bottom: TabBar(
            tabs: [
              Tab(text: l10n.infoTab1, icon: const Icon(Icons.help_outline)),
              Tab(text: l10n.infoTab2, icon: const Icon(Icons.info_outline)),
              Tab(text: l10n.infoTab3, icon: const Icon(Icons.settings_suggest_outlined)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _AppGuideTab(),
            _FermentsInfoTab(),
            _AdvancedFeaturesTab(),
          ],
        ),
      ),
    );
  }
}

// ── Pestaña 1: Guía de la App ──────────────────────────────────────────────

class _AppGuideTab extends StatelessWidget {
  const _AppGuideTab();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.infoGuideTitle,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.infoGuideDesc,
            style: const TextStyle(fontSize: 16, height: 1.5),
          ),
          const SizedBox(height: 24),
          _buildGuideStep(
            context,
            Icons.play_circle_fill,
            l10n.infoGuideStep1Title,
            l10n.infoGuideStep1Desc,
          ),
          _buildGuideStep(
            context,
            Icons.refresh_rounded,
            l10n.infoGuideStepHarvestTitle,
            l10n.infoGuideStepHarvestDesc,
          ),
          _buildGuideStep(
            context,
            Icons.tune_rounded,
            l10n.infoGuideStepAdjustTitle,
            l10n.infoGuideStepAdjustDesc,
          ),
          _buildGuideStep(
            context,
            Icons.history,
            l10n.infoGuideStep2Title,
            l10n.infoGuideStep2Desc,
          ),
          _buildGuideStep(
            context,
            Icons.notifications_active,
            l10n.infoGuideStep3Title,
            l10n.infoGuideStep3Desc,
          ),
        ],
      ),
    );
  }

  Widget _buildGuideStep(
      BuildContext context, IconData icon, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 32, color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 8),
                Text(description,
                    style: const TextStyle(height: 1.4, fontSize: 15)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Pestaña 2: Información de Fermentos ───────────────────────────────────

class _FermentsInfoTab extends StatelessWidget {
  const _FermentsInfoTab();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SECCIÓN KÉFIR
          Text(
            l10n.infoCard1Title,
            style: theme.textTheme.headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold, color: Colors.teal),
          ),
          const SizedBox(height: 12),
          Text(
            l10n.infoCard1Desc,
            style: const TextStyle(fontSize: 16, height: 1.5),
          ),
          const SizedBox(height: 16),
          _buildProcessSection(
            context,
            l10n.infoProcessTitle,
            [
              (Icons.looks_one, l10n.infoProcessStep1Title, l10n.infoProcessStep1Desc),
              (Icons.looks_two, l10n.infoProcessStep2Title, l10n.infoProcessStep2Desc),
              (Icons.looks_3, l10n.infoProcessStep3Title, l10n.infoProcessStep3Desc),
            ],
            Colors.teal,
          ),
          
          const Divider(height: 48),

          // SECCIÓN KOMBUCHA
          Text(
            l10n.infoKombuchaTitle,
            style: theme.textTheme.headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold, color: Colors.amber[800]),
          ),
          const SizedBox(height: 12),
          Text(
            l10n.infoKombuchaDesc,
            style: const TextStyle(fontSize: 16, height: 1.5),
          ),
          const SizedBox(height: 16),
          _buildProcessSection(
            context,
            l10n.infoKombuchaProcessTitle,
            [
              (Icons.looks_one, l10n.infoKombuchaStep1Title, l10n.infoKombuchaStep1Desc),
              (Icons.looks_two, l10n.infoKombuchaStep2Title, l10n.infoKombuchaStep2Desc),
            ],
            Colors.amber[800]!,
          ),

          const SizedBox(height: 24),
          _buildTipCard(context, l10n.infoCard3Title, l10n.infoCard3Desc),
        ],
      ),
    );
  }

  Widget _buildProcessSection(BuildContext context, String title,
      List<(IconData, String, String)> steps, Color accentColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ...steps.map((step) => Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(step.$1, size: 28, color: accentColor),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(step.$2,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 4),
                        Text(step.$3, style: const TextStyle(height: 1.4)),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  Widget _buildTipCard(BuildContext context, String title, String description) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.lightbulb_outline, color: Colors.amber, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 4),
                  Text(description, style: const TextStyle(fontStyle: FontStyle.italic, height: 1.4)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Pestaña 3: Funciones Avanzadas ────────────────────────────────────────

class _AdvancedFeaturesTab extends StatelessWidget {
  const _AdvancedFeaturesTab();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAdvancedInfo(
            context,
            Icons.calendar_month_outlined,
            l10n.infoAdvancedCalendarTitle,
            l10n.infoAdvancedCalendarDesc,
          ),
          _buildAdvancedInfo(
            context,
            Icons.auto_awesome_outlined,
            l10n.infoAdvancedHistoryTitle,
            l10n.infoAdvancedHistoryDesc,
          ),
          _buildAdvancedInfo(
            context,
            Icons.save_outlined,
            l10n.infoAdvancedDataTitle,
            l10n.infoAdvancedDataDesc,
          ),
        ],
      ),
    );
  }

  Widget _buildAdvancedInfo(
      BuildContext context, IconData icon, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Theme.of(context).colorScheme.secondary),
              const SizedBox(width: 12),
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(fontSize: 16, height: 1.5),
          ),
        ],
      ),
    );
  }
}
