import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portfolio/src/constants/themes.dart' as themes;
import 'package:portfolio/src/features/general/presentation/general_section.dart';
import 'package:portfolio/src/features/general/provider/dark_mode_controller.dart';
import 'package:portfolio/src/localization/translation_helpers.dart';
import 'package:portfolio/src/localization/translation_keys.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Portfolio',
      onGenerateTitle: (_) => tr(ref, TranslationKeys.name),
      theme: themes.lightTheme,
      darkTheme: themes.darkTheme,
      themeMode: ref.watch(darkModeProvider).maybeWhen(data: (darkMode) => darkMode ? ThemeMode.dark : ThemeMode.light, orElse: () => ThemeMode.system),
      home: const GeneralSection(),
    );
  }
}
