import 'package:collection/collection.dart';
import 'package:portfolio/src/localization/translation_helpers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portfolio/src/common/data/language_repository.dart';
import 'package:portfolio/src/common/widgets/icon.dart';
import 'package:portfolio/src/constants/sizes.dart';
import 'package:portfolio/src/localization/translation_keys.dart';
import 'package:portfolio/src/common/domain/language.dart';
import 'package:portfolio/src/localization/locale_controller.dart';

class LocaleButton extends ConsumerWidget {
  const LocaleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languages = ref.watch(languageRepositoryProvider).getLanguages();

    return DropdownButton<Locale>(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      value: ref.watch(localeControllerProvider),
      dropdownColor: Theme.of(context).colorScheme.primary,
      focusNode: FocusNode(canRequestFocus: false),
      focusColor: Colors.transparent,
      underline: const SizedBox.shrink(),
      items: languages.mapIndexed((index, language) {
        return DropdownMenuItem<Locale>(
          value: Locale(language.code ?? ""),
          child: Row(
            children: [
              MyIcon(icon: language.icon, placeholder: const Icon(Icons.translate)),
              gapW8,
              Text(_getLanguageName(ref, language)),
            ],
          ),
        );
      }).toList(),
      onChanged: (locale) async {
        await _onLocaleChanged(context, ref, locale: locale);
      },
    );
  }

  Future<void> _onLocaleChanged(BuildContext context, WidgetRef ref, {required Locale? locale}) async {
    if (locale != null) {
      await ref.read(localeControllerProvider.notifier).setLocale(locale);
    }
  }

  String _getLanguageName(WidgetRef ref, Language language) {
    final languageName = language.name;
    final languageNativeName = language.nativeName;
    if (languageNativeName != null) return languageNativeName;
    if (languageName != null) return languageName;
    return tr(ref, TranslationKeys.unknownLanguageError);
  }
}
