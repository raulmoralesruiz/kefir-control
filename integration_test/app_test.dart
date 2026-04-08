import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:kefir_control/main.dart' as app;
import 'package:kefir_control/providers/locale_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Idiomas para los que se generarán capturas.
/// El prefijo de carpeta coincide con las carpetas de Fastlane:
///   fastlane/metadata/android/<folder>/images/phoneScreenshots/
const List<Map<String, String>> kLocales = [
  {'locale': 'es', 'folder': 'es-ES'},
  {'locale': 'en', 'folder': 'en-US'},
];

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
  });

  for (final localeInfo in kLocales) {
    final localeCode = localeInfo['locale']!;
    final folderName = localeInfo['folder']!;

    testWidgets('Screenshots – $folderName', (WidgetTester tester) async {
      // Reiniciar SharedPreferences para cada idioma
      SharedPreferences.setMockInitialValues({});

      // Arrancar la app y fijar el locale
      app.main();
      await tester.pumpAndSettle();

      final element = tester.element(find.byType(app.KefirControlApp));
      final rootContainer = ProviderScope.containerOf(element);
      await rootContainer.read(localeProvider.notifier).setLocale(Locale(localeCode));
      await tester.pumpAndSettle();

      // Necesario para Android: convertir la superficie antes de capturar
      await binding.convertFlutterSurfaceToImage();
      await tester.pumpAndSettle();

      // ── PANTALLA 1: Home vacío ──────────────────────────────────────────
      await binding.takeScreenshot('${folderName}_01_home_empty');

      // ── PANTALLA 2: Selección de tipo (Kéfir o Kombucha) ──────────────────
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      await binding.takeScreenshot('${folderName}_02_type_selection');

      // Seleccionamos Kombucha para mostrar el nuevo branding
      await tester.tap(find.byIcon(Icons.emoji_food_beverage));
      await tester.pumpAndSettle();

      // ── PANTALLA 3: Selección de duración (Kombucha branding) ─────────────
      await binding.takeScreenshot('${folderName}_03_duration_selection_kombucha');

      // Iniciamos una fermentación de Kombucha para ver la tarjeta
      // (Tap en el botón de tiempo personalizado o similar, usaremos el primero disponible)
      await tester.tap(find.byIcon(Icons.tune));
      await tester.pumpAndSettle();
      
      // En el picker, aceptamos (Confirmar)
      await tester.pumpAndSettle(const Duration(seconds: 1));
      final confirmBtn = find.textContaining(localeCode == 'es' ? 'Usar' : 'Use');
      expect(confirmBtn, findsOneWidget);
      await tester.tap(confirmBtn);
      await tester.pumpAndSettle();

      // ── PANTALLA 4: Tarjeta de progreso activa ───────────────────────────
      await binding.takeScreenshot('${folderName}_04_progress_card');

      // ── PANTALLA 5: Calendario ───────────────────────────────────────────
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.calendar_month_outlined));
      await tester.pumpAndSettle();
      await binding.takeScreenshot('${folderName}_05_calendar');
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      // ── PANTALLA 6: Historial ────────────────────────────────────────────
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.history_outlined));
      await tester.pumpAndSettle();
      await binding.takeScreenshot('${folderName}_06_history');
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      // ── PANTALLA 7: Info - Guía ──────────────────────────────────────────
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.info_outline));
      await tester.pumpAndSettle();
      // Estamos en la pestaña 1 (Guía) por defecto o tras el refactor
      await tester.tap(find.byIcon(Icons.help_outline)); // Aseguramos pestaña guía
      await tester.pumpAndSettle();
      await binding.takeScreenshot('${folderName}_07_info_guide');

      // ── PANTALLA 8: Info - Fermentos ─────────────────────────────────────
      await tester.tap(find.byIcon(Icons.info_outline)); // Icono de la segunda pestaña
      await tester.pumpAndSettle();
      await binding.takeScreenshot('${folderName}_08_info_ferments');

      // ── PANTALLA 9: Info - Avanzado ──────────────────────────────────────
      await tester.tap(find.byIcon(Icons.settings_suggest_outlined)); // Icono de la tercera pestaña
      await tester.pumpAndSettle();
      await binding.takeScreenshot('${folderName}_09_info_advanced');

      // Volver a Home
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      // Resetear locale
      final elementToReset = tester.element(find.byType(app.KefirControlApp));
      ProviderScope.containerOf(elementToReset).read(localeProvider.notifier).setLocale(null);
    });
  }
}
