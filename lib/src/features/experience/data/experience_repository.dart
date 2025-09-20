import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portfolio/src/features/experience/domain/experience.dart';
import 'package:portfolio/src/localization/translation_keys.dart';
import 'package:portfolio/src/localization/custom_localization_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'experience_repository.g.dart';

@riverpod
ExperienceRepository experienceRepository(ExperienceRepositoryRef ref) {
  return ExperienceRepository(ref);
}

class ExperienceRepository {
  ExperienceRepository(this._ref);

  final Ref _ref;

  List<Experience> getExperiences() {
    final localizationService = _ref.watch(localizationServiceProvider);
    final jsonExperiences = localizationService.translateList(TranslationKeys.experiences);
    final experiences = jsonExperiences.map((jsonExperience) {
      return Experience.fromJson(jsonExperience);
    }).toList();
    return experiences;
  }
}
