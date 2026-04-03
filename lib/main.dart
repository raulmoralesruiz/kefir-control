import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kefir_control/l10n/app_localizations.dart';
import 'screens/home_screen.dart';
import 'providers/locale_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: KefirControlApp()));
}

class KefirControlApp extends ConsumerWidget {
  const KefirControlApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = ColorScheme.fromSeed(seedColor: Colors.teal);
    final locale = ref.watch(localeProvider);
    
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
  }
}
