import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Información'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Sobre el Kéfir', icon: Icon(Icons.info_outline)),
              Tab(text: 'Guía de la App', icon: Icon(Icons.help_outline)),
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
            '¿Qué es el Kéfir de Leche?',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            'El kéfir de leche es una bebida láctea fermentada originaria de la región del Cáucaso. Se produce mediante la acción de los "nódulos o gránulos de kéfir", que son una combinación simbiótica de bacterias probióticas y levaduras en una matriz de proteínas, lípidos y azúcares.',
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
          const SizedBox(height: 24),
          Text(
            'El Proceso de Fermentación',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            Icons.looks_one,
            'Preparación',
            'Se introducen los nódulos de kéfir en leche a temperatura ambiente, preferiblemente leche entera (aunque también puede ser semidesnatada o desnatada).',
          ),
          _buildInfoRow(
            Icons.looks_two,
            'Fermentación (24h - 48h)',
            'Los microorganismos consumen la lactosa de la leche, transformándola en ácido láctico (lo que le da su sabor ácido), dióxido de carbono y otros compuestos beneficiosos. A mayor tiempo, más espeso y ácido se vuelve.',
          ),
          _buildInfoRow(
            Icons.looks_3,
            'Recolección',
            'Se cuela la mezcla con un colador no metálico. El líquido resultante es la bebida de kéfir lista para consumir, y los nódulos recuperados se vuelven a introducir en nueva leche para repetir el ciclo.',
          ),
          const SizedBox(height: 24),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.lightbulb_outline, color: Colors.amber, size: 32),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Consejo: Nunca uses utensilios de metal (cucharas, coladores) al manipular los gránulos, ya que pueden dañarlos.',
                      style: TextStyle(fontStyle: FontStyle.italic),
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
            'Cómo usar Kéfir Control',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            'Esta aplicación está diseñada para ayudarte a llevar un control preciso de los tiempos de tus fermentaciones, evitando que tu kéfir se vuelva excesivamente ácido por olvido.',
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
          const SizedBox(height: 24),
          _buildGuideStep(
            Icons.play_circle_fill,
            'Iniciar Fermentación Ahora',
            'Pulsa este botón justo después de mezclar la leche con los nódulos. Te pedirá que elijas cuánto tiempo quieres que fermente (24, 36 o 48 horas). La app programará una alarma automática.',
          ),
          _buildGuideStep(
            Icons.history,
            'Registrar Fermentación Pasada',
            '¿Se te olvidó darle al botón cuando preparaste el kéfir esta mañana? No pasa nada. Usa esta opción para indicar a qué hora (y día) exacta hiciste la mezcla en la vida real. La app calculará el tiempo transcurrido desde entonces.',
          ),
          _buildGuideStep(
            Icons.notifications_active,
            'Notificaciones',
            'Puedes cerrar la aplicación sin miedo. Cuando el tiempo objetivo se alcance, recibirás una notificación en tu dispositivo avisándote de que es hora de colar el kéfir.',
          ),
          _buildGuideStep(
            Icons.stop_circle_outlined,
            'Finalizar Fermentación',
            'Pulsa este botón rojo una vez hayas colado el kéfir para limpiar el temporizador y dejar la aplicación lista para tu próxima recolección.',
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
