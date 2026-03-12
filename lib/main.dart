import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kefir_control/l10n/app_localizations.dart';
import 'screens/home_screen.dart';

// Notifier global para el locale seleccionado por el usuario.
// null = usar el locale del sistema.
final ValueNotifier<Locale?> appLocaleNotifier = ValueNotifier<Locale?>(null);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const KefirControlApp());
}

class KefirControlApp extends StatelessWidget {
  const KefirControlApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(seedColor: Colors.teal);

    return ValueListenableBuilder<Locale?>(
      valueListenable: appLocaleNotifier,
      builder: (context, locale, _) {
        return MaterialApp(
          onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
          locale: locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          theme: ThemeData(
            colorScheme: colorScheme,
            useMaterial3: true,
            datePickerTheme: DatePickerThemeData(
              cancelButtonStyle: FilledButton.styleFrom(
                backgroundColor: colorScheme.secondaryContainer,
                foregroundColor: colorScheme.onSecondaryContainer,
              ),
              confirmButtonStyle: FilledButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
              ),
            ),
            timePickerTheme: TimePickerThemeData(
              cancelButtonStyle: FilledButton.styleFrom(
                backgroundColor: colorScheme.secondaryContainer,
                foregroundColor: colorScheme.onSecondaryContainer,
              ),
              confirmButtonStyle: FilledButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
              ),
            ),
            cardTheme: CardThemeData(
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey.shade300, width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.transparent,
            ),
          ),
          home: const HomeScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
