import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/firebase_options.dart';
import 'package:portfolio/src/app.dart';
import 'package:portfolio/src/app_startup.dart';
import 'package:portfolio/src/localization/custom_localization_service.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setPathUrlStrategy();
  GoogleFonts.config.allowRuntimeFetching = false;

  runApp(
    ProviderScope(
      child: AppStartupWidget(
        onLoaded: (context) {
          return Consumer(
            builder: (context, ref, child) {
              // Initialize the custom localization service
              final localizationService = ref.watch(localizationServiceProvider);
              final isLoaded = ref.watch(translationsLoadedProvider);

              // Initialize translations if not loaded
              if (!isLoaded) {
                // Use a future to ensure initialization completes
                Future.microtask(() => localizationService.initialize());
                // Show loading screen while translations are being fetched
                return MaterialApp(
                  title: 'Portfolio',
                  home: Scaffold(
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircularProgressIndicator(),
                          const SizedBox(height: 16),
                          Text('Loading translations...', style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    ),
                  ),
                );
              }

              return const MyApp();
            },
          );
        },
      ),
    ),
  );
}
