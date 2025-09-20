import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portfolio/src/localization/custom_localization_service.dart';

class ScaffoldMessengerHelper {
  ScaffoldMessengerHelper._();

  static void showLaunchUrlError(BuildContext context, {String? url}) {
    if (context.mounted) {
      // Get the translation service from the context
      final container = ProviderScope.containerOf(context);
      final service = container.read(localizationServiceProvider);
      final errorMessage = service.translate('openUrlError');

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$errorMessage $url")));
    }
  }
}
