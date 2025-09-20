import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portfolio/src/common/domain/language.dart';
import 'package:portfolio/src/localization/translation_keys.dart';
import 'package:portfolio/src/localization/custom_localization_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'language_repository.g.dart';

@riverpod
LanguageRepository languageRepository(LanguageRepositoryRef ref) {
  return LanguageRepository(ref);
}

class LanguageRepository {
  LanguageRepository(this._ref);

  final Ref _ref;

  List<Language> getLanguages() {
    final localizationService = _ref.watch(localizationServiceProvider);
    final jsonLanguages = localizationService.translateList(TranslationKeys.languages);
    final languages = jsonLanguages.map((jsonLanguage) {
      return Language.fromJson(jsonLanguage);
    }).toList();
    return languages;
  }
}
