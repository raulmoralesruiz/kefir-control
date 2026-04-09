import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'providers/theme_provider.dart';
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
    final locale = ref.watch(localeProvider);
    final themeMode = ref.watch(themeProvider);
    
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
      theme: FlexThemeData.light(
        scheme: FlexScheme.tealM3,
        useMaterial3: true,
        subThemesData: const FlexSubThemesData(
          interactionEffects: true,
          tintedDisabledControls: true,
          useMaterial3Typography: true,
          inputDecoratorBorderType: FlexInputBorderType.outline,
          inputDecoratorUnfocusedBorderIsColored: false,
          tooltipRadius: 4,
          tooltipSchemeColor: SchemeColor.inverseSurface,
          tooltipOpacity: 0.9,
          snackBarElevation: 6,
          snackBarBackgroundSchemeColor: SchemeColor.inverseSurface,
          navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
          navigationBarUnselectedLabelSchemeColor: SchemeColor.onSurface,
          navigationBarSelectedIconSchemeColor: SchemeColor.primary,
          navigationBarUnselectedIconSchemeColor: SchemeColor.onSurface,
          navigationBarIndicatorSchemeColor: SchemeColor.primaryContainer,
          navigationBarIndicatorOpacity: 1.00,
          navigationBarBackgroundSchemeColor: SchemeColor.surfaceContainerLowest,
          navigationBarElevation: 0,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
      ),
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.tealM3,
        useMaterial3: true,
        subThemesData: const FlexSubThemesData(
          interactionEffects: true,
          tintedDisabledControls: true,
          useMaterial3Typography: true,
          inputDecoratorBorderType: FlexInputBorderType.outline,
          inputDecoratorUnfocusedBorderIsColored: false,
          tooltipRadius: 4,
          tooltipSchemeColor: SchemeColor.inverseSurface,
          tooltipOpacity: 0.9,
          snackBarElevation: 6,
          snackBarBackgroundSchemeColor: SchemeColor.inverseSurface,
          navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
          navigationBarUnselectedLabelSchemeColor: SchemeColor.onSurface,
          navigationBarSelectedIconSchemeColor: SchemeColor.primary,
          navigationBarUnselectedIconSchemeColor: SchemeColor.onSurface,
          navigationBarIndicatorSchemeColor: SchemeColor.primaryContainer,
          navigationBarIndicatorOpacity: 1.00,
          navigationBarBackgroundSchemeColor: SchemeColor.surfaceContainerLowest,
          navigationBarElevation: 0,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
      ),
      themeMode: themeMode,
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
