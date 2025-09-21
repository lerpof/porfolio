import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                    backgroundColor: Colors.grey[50],
                    body: Center(
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 32),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(width: 60, height: 60, child: CircularProgressIndicator(strokeWidth: 6, valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent))),
                              const SizedBox(height: 24),
                              Text(
                                'Loading translations...',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.blueGrey[700], fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
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

Future<void> saveProfile() async {
  String jsonString = await rootBundle.loadString('assets/translations/en.json');
  Map<String, dynamic> profileData = Map<String, dynamic>.from(jsonDecode(jsonString));

  await FirebaseFirestore.instance.collection('portfolio').doc('en').set(profileData);

  jsonString = await rootBundle.loadString('assets/translations/it.json');
  profileData = Map<String, dynamic>.from(jsonDecode(jsonString));

  await FirebaseFirestore.instance.collection('portfolio').doc('it').set(profileData);

  jsonString = await rootBundle.loadString('assets/translations/fr.json');
  profileData = Map<String, dynamic>.from(jsonDecode(jsonString));

  await FirebaseFirestore.instance.collection('portfolio').doc('fr').set(profileData);
}
