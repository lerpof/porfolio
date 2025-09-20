import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portfolio/src/features/personal_info/domain/contact.dart';
import 'package:portfolio/src/features/personal_info/domain/resume.dart';
import 'package:portfolio/src/localization/translation_keys.dart';
import 'package:portfolio/src/localization/custom_localization_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'personal_info_repository.g.dart';

@riverpod
PersonalInfoRepository personalInfoRepository(PersonalInfoRepositoryRef ref) {
  return PersonalInfoRepository(ref);
}

class PersonalInfoRepository {
  PersonalInfoRepository(this._ref);

  final Ref _ref;

  List<Resume> getResumes() {
    final localizationService = _ref.watch(localizationServiceProvider);
    final jsonResumes = localizationService.translateList(TranslationKeys.resumes);
    final resumes = jsonResumes.map((jsonResume) {
      return Resume.fromJson(jsonResume);
    }).toList();
    return resumes;
  }

  List<Contact> getContacts() {
    final localizationService = _ref.watch(localizationServiceProvider);
    final jsonContacts = localizationService.translateList(TranslationKeys.contacts);
    final contacts = jsonContacts.map((jsonContact) {
      return Contact.fromJson(jsonContact);
    }).toList();
    return contacts;
  }
}
