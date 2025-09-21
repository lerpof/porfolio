import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:convert';

class CustomLocalizationService extends ChangeNotifier {
  static const List<Locale> supportedLocales = [Locale('en'), Locale('it'), Locale('fr')];

  Locale _currentLocale = const Locale('en');
  final Map<String, Map<String, dynamic>> _translations = {};
  bool _isLoaded = false;

  Locale get currentLocale => _currentLocale;
  bool get isLoaded => _isLoaded;

  /// Initialize the service by fetching translations from Firestore
  Future<void> initialize() async {
    if (_isLoaded) {
      debugPrint('Localization service already initialized');
      return;
    }

    debugPrint('Initializing localization service...');
    try {
      // First try to fetch from Firestore
      bool firestoreSuccess = false;
      for (final locale in supportedLocales) {
        debugPrint('Fetching translations for ${locale.languageCode}...');
        final success = await _fetchTranslationsForLocale(locale.languageCode);
        if (success) firestoreSuccess = true;
      }

      // If Firestore failed, fallback to local assets
      if (!firestoreSuccess) {
        debugPrint('Firestore failed, falling back to local assets...');
        await _loadLocalTranslations();
      }

      _isLoaded = true;
      debugPrint('Localization service initialized successfully');
      debugPrint('Available translations: ${_translations.keys.toList()}');
      notifyListeners();
    } catch (e) {
      debugPrint('Error initializing localization service: $e');
      // Try local assets as final fallback
      try {
        await _loadLocalTranslations();
      } catch (localError) {
        debugPrint('Local assets fallback failed: $localError');
      }
      _isLoaded = true;
      notifyListeners();
    }
  }

  /// Load translations from local JSON assets
  Future<void> _loadLocalTranslations() async {
    try {
      for (final locale in supportedLocales) {
        final String jsonString = await rootBundle.loadString('assets/translations/${locale.languageCode}.json');
        final Map<String, dynamic> data = json.decode(jsonString);
        _translations[locale.languageCode] = data;
        debugPrint('Loaded local translations for ${locale.languageCode}');
      }
    } catch (e) {
      debugPrint('Error loading local translations: $e');
    }
  }

  /// Fetch translations for a specific locale from Firestore
  Future<bool> _fetchTranslationsForLocale(String languageCode) async {
    try {
      final doc = await FirebaseFirestore.instance.collection('portfolio').doc(languageCode).get();

      if (doc.exists && doc.data() != null) {
        _translations[languageCode] = doc.data()!;
        debugPrint('Loaded translations for $languageCode');
        return true;
      } else {
        debugPrint('No translations found for $languageCode in Firestore');
        return false;
      }
    } catch (e) {
      debugPrint('Error fetching translations for $languageCode: $e');
      return false;
    }
  }

  /// Change the current locale
  void setLocale(Locale locale) {
    if (supportedLocales.contains(locale) && locale != _currentLocale) {
      _currentLocale = locale;
      notifyListeners();
    }
  }

  /// Get a translated string by key
  String translate(String key) {
    final currentTranslations = _translations[_currentLocale.languageCode];
    if (currentTranslations == null) {
      debugPrint('No translations loaded for ${_currentLocale.languageCode}');
      debugPrint('Available locales: ${_translations.keys.toList()}');
      return key;
    }

    final result = _getNestedValue(currentTranslations, key);
    if (result == null) {
      debugPrint('Translation not found for key: $key in locale: ${_currentLocale.languageCode}');
      debugPrint('Available keys: ${currentTranslations.keys.toList()}');
      return key;
    }

    return result.toString();
  }

  /// Get a list of translated objects (useful for contacts, experiences, etc.)
  List<Map<String, dynamic>> translateList(String key) {
    final currentTranslations = _translations[_currentLocale.languageCode];
    if (currentTranslations == null) {
      debugPrint('No translations loaded for ${_currentLocale.languageCode}');
      return [];
    }

    final value = _getNestedValue(currentTranslations, key);
    if (value is List) {
      return List<Map<String, dynamic>>.from(value);
    }
    return [];
  }

  /// Get a nested value from translations using dot notation (e.g., "user.name")
  dynamic _getNestedValue(Map<String, dynamic> map, String key) {
    final keys = key.split('.');
    dynamic current = map;

    for (final k in keys) {
      if (current is Map<String, dynamic> && current.containsKey(k)) {
        current = current[k];
      } else {
        return null;
      }
    }

    return current;
  }

  /// Refresh translations from Firestore
  Future<void> refresh() async {
    _translations.clear();
    _isLoaded = false;
    notifyListeners();
    await initialize();
  }
}

// Riverpod provider for the localization service
final localizationServiceProvider = ChangeNotifierProvider<CustomLocalizationService>((ref) {
  return CustomLocalizationService();
});

// Provider to get the current locale
final currentLocaleProvider = Provider<Locale>((ref) {
  return ref.watch(localizationServiceProvider).currentLocale;
});

// Provider to check if translations are loaded
final translationsLoadedProvider = Provider<bool>((ref) {
  return ref.watch(localizationServiceProvider).isLoaded;
});
