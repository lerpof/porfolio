import 'dart:ui';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portfolio/src/localization/custom_localization_service.dart';

/// Legacy function for compatibility - now uses the custom localization service
List<Map<String, dynamic>> trList(Locale locale, String key) {
  // This function is kept for backward compatibility but should be replaced
  // with the new trList function from translation_helpers.dart
  // For now, it returns an empty list as it requires a WidgetRef
  return [];
}

/// Use this function with WidgetRef instead
List<Map<String, dynamic>> trListWithRef(WidgetRef ref, String key) {
  return ref.watch(localizationServiceProvider).translateList(key);
}
