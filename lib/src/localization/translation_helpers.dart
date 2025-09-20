import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portfolio/src/localization/custom_localization_service.dart';

/// Extension on String to add translation functionality
extension StringTranslation on String {
  /// Translate this string using the custom localization service
  String tr(BuildContext context) {
    final container = ProviderScope.containerOf(context);
    final service = container.read(localizationServiceProvider);
    return service.translate(this);
  }
}

/// Widget that provides translation context
class TranslationBuilder extends ConsumerWidget {
  final Widget Function(BuildContext context, CustomLocalizationService service) builder;

  const TranslationBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final service = ref.watch(localizationServiceProvider);
    return builder(context, service);
  }
}

/// Helper function to get translations anywhere in the app
CustomLocalizationService getTranslationService(WidgetRef ref) {
  return ref.watch(localizationServiceProvider);
}

/// Helper function to translate a key
String tr(WidgetRef ref, String key) {
  return ref.watch(localizationServiceProvider).translate(key);
}

/// Helper function to translate a list
List<Map<String, dynamic>> trList(WidgetRef ref, String key) {
  return ref.watch(localizationServiceProvider).translateList(key);
}
