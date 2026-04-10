import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'locale_provider.g.dart';

const _kLanguageCodeKey = 'language_code';
const _kCountryCodeKey = 'country_code';

@riverpod
class LocaleNotifier extends _$LocaleNotifier {
  @override
  Locale? build() {
    _loadLocale();
    return null; // El valor inicial será nulo (defecto de sistema) hasta que se cargue
  }

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString(_kLanguageCodeKey);
    final countryCode = prefs.getString(_kCountryCodeKey);
    if (langCode != null) {
      state = Locale(langCode, countryCode);
    }
  }

  Future<void> setLocale(Locale? locale) async {
    state = locale;
    final prefs = await SharedPreferences.getInstance();
    if (locale == null) {
      await prefs.remove(_kLanguageCodeKey);
      await prefs.remove(_kCountryCodeKey);
    } else {
      await prefs.setString(_kLanguageCodeKey, locale.languageCode);
      if (locale.countryCode != null) {
        await prefs.setString(_kCountryCodeKey, locale.countryCode!);
      } else {
        await prefs.remove(_kCountryCodeKey);
      }
    }
  }
}
