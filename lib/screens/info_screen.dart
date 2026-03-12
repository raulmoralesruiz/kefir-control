import 'package:flutter/material.dart';
import 'package:kefir_control/l10n/app_localizations.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.infoTitle),
          bottom: TabBar(
            tabs: [
              Tab(text: AppLocalizations.of(context)!.infoTab1, icon: const Icon(Icons.info_outline)),
              Tab(text: AppLocalizations.of(context)!.infoTab2, icon: const Icon(Icons.help_outline)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _KefirInfoTab(),
            _AppGuideTab(),
          ],
        ),
      ),
    );
  }
}

class _KefirInfoTab extends StatelessWidget {
  const _KefirInfoTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.infoCard1Title,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.infoCard1Desc,
            style: const TextStyle(fontSize: 16, height: 1.5),
          ),
          const SizedBox(height: 24),
          Text(
            AppLocalizations.of(context)!.infoProcessTitle,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            Icons.looks_one,
            AppLocalizations.of(context)!.infoProcessStep1Title,
            AppLocalizations.of(context)!.infoProcessStep1Desc,
          ),
          _buildInfoRow(
            Icons.looks_two,
            AppLocalizations.of(context)!.infoProcessStep2Title,
            AppLocalizations.of(context)!.infoProcessStep2Desc,
          ),
          _buildInfoRow(
            Icons.looks_3,
            AppLocalizations.of(context)!.infoProcessStep3Title,
            AppLocalizations.of(context)!.infoProcessStep3Desc,
          ),
          const SizedBox(height: 24),
          Card(
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
                        Text(
                          AppLocalizations.of(context)!.infoCard3Title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          AppLocalizations.of(context)!.infoCard3Desc,
                          style: const TextStyle(
                              fontStyle: FontStyle.italic, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 28, color: Colors.teal),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(description, style: const TextStyle(height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AppGuideTab extends StatelessWidget {
  const _AppGuideTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.infoGuideTitle,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.infoGuideDesc,
            style: const TextStyle(fontSize: 16, height: 1.5),
          ),
          const SizedBox(height: 24),
          _buildGuideStep(
            Icons.play_circle_fill,
            AppLocalizations.of(context)!.infoGuideStep1Title,
            AppLocalizations.of(context)!.infoGuideStep1Desc,
          ),
          _buildGuideStep(
            Icons.history,
            AppLocalizations.of(context)!.infoGuideStep2Title,
            AppLocalizations.of(context)!.infoGuideStep2Desc,
          ),
          _buildGuideStep(
            Icons.notifications_active,
            AppLocalizations.of(context)!.infoGuideStep3Title,
            AppLocalizations.of(context)!.infoGuideStep3Desc,
          ),
          _buildGuideStep(
            Icons.stop_circle_outlined,
            AppLocalizations.of(context)!.infoGuideStep4Title,
            AppLocalizations.of(context)!.infoGuideStep4Desc,
          ),
        ],
      ),
    );
  }

  Widget _buildGuideStep(IconData icon, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.teal.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 32, color: Colors.teal),
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
