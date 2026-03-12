import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:kefir_control/main.dart' as app;
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
      app.appLocaleNotifier.value = Locale(localeCode);
      await tester.pumpAndSettle();

      // Necesario para Android: convertir la superficie antes de capturar
      await binding.convertFlutterSurfaceToImage();
      await tester.pumpAndSettle();

      // ── PANTALLA 1: Home vacío (sin fermentación activa) ──────────────────
      await binding.takeScreenshot('${folderName}_01_home_empty');

      // ── PANTALLA 2: Bottom Sheet de opciones de inicio ────────────────────
      await tester.tap(find.byIcon(Icons.play_circle_fill));
      await tester.pumpAndSettle();
      await binding.takeScreenshot('${folderName}_02_start_options');

      // Tap en "Iniciar fermentación" (primer botón en el BottomSheet, es un FilledButton)
      await tester.tap(find.byType(FilledButton).first);
      await tester.pumpAndSettle();

      // ── PANTALLA 3: Diálogo de selección de horas ─────────────────────────
      await binding.takeScreenshot('${folderName}_03_start_dialog');

      // Tap en el botón "Iniciar" del diálogo (último FilledButton en pantalla)
      final startBtn = find.byType(FilledButton).last;
      await tester.tap(startBtn);
      await tester.pumpAndSettle();

      // ── PANTALLA 4: Progreso de fermentación activa ────────────────────────
      await binding.takeScreenshot('${folderName}_04_progress');

      // ── PANTALLA 5: Historial (vía NavigationDrawer) ────────────────────────
      // Abrir el Drawer
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      // Tap en la opción "Historial" (buscamos por el icono Icons.history_outlined)
      await tester.tap(find.byIcon(Icons.history_outlined));
      await tester.pumpAndSettle();
      await binding.takeScreenshot('${folderName}_05_history');

      // Volver a Home
      if (tester.any(find.byType(BackButton))) {
        await tester.tap(find.byType(BackButton));
        await tester.pumpAndSettle();
      } else {
        // Fallback si el drawer o la página no tienen back button estándar
        await tester.pageBack();
        await tester.pumpAndSettle();
      }

      // ── PANTALLA 6: Info – pestaña "Sobre el Kéfir" (vía NavigationDrawer) ──
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.info_outline));
      await tester.pumpAndSettle();
      await binding.takeScreenshot('${folderName}_06_info_kefir');

      // Cambiar a segunda pestaña (Guía de la App / App Guide)
      await tester.tap(find.byIcon(Icons.help_outline));
      await tester.pumpAndSettle();
      await binding.takeScreenshot('${folderName}_07_info_guide');

      // Volver a Home
      // await tester.pageBack();
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      // Resetear locale para no interferir entre tests
      app.appLocaleNotifier.value = null;
    });
  }
}
