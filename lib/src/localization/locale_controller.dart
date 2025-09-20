import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portfolio/src/localization/custom_localization_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Provider to manage locale persistence
final localeControllerProvider = StateNotifierProvider<LocaleController, Locale>((ref) {
  return LocaleController(ref);
});

class LocaleController extends StateNotifier<Locale> {
  final Ref _ref;
  static const String _localeKey = 'saved_locale';

  LocaleController(this._ref) : super(const Locale('en')) {
    _loadSavedLocale();
  }

  Future<void> _loadSavedLocale() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedLocaleCode = prefs.getString(_localeKey);
      
      if (savedLocaleCode != null) {
        final savedLocale = Locale(savedLocaleCode);
        if (CustomLocalizationService.supportedLocales.contains(savedLocale)) {
          state = savedLocale;
          _ref.read(localizationServiceProvider).setLocale(savedLocale);
        }
      }
    } catch (e) {
      // If there's an error loading saved locale, use default
      debugPrint('Error loading saved locale: $e');
    }
  }

  Future<void> setLocale(Locale locale) async {
    if (CustomLocalizationService.supportedLocales.contains(locale)) {
      state = locale;
      _ref.read(localizationServiceProvider).setLocale(locale);
      
      // Save the locale preference
      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_localeKey, locale.languageCode);
      } catch (e) {
        debugPrint('Error saving locale: $e');
      }
    }
  }
}
