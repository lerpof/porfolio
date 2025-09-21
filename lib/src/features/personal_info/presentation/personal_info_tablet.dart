import 'package:portfolio/src/localization/translation_helpers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portfolio/src/constants/sizes.dart';
import 'package:portfolio/src/features/personal_info/data/personal_info_repository.dart';
import 'package:portfolio/src/features/personal_info/domain/resume.dart';
import 'package:portfolio/src/features/personal_info/presentation/widgets/contact_bar.dart';
import 'package:portfolio/src/features/personal_info/presentation/widgets/resume_button.dart';
import 'package:portfolio/src/localization/translation_keys.dart';
import 'package:portfolio/src/remote_assets.dart';

class PersonalInfoTablet extends ConsumerWidget {
  const PersonalInfoTablet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resumes = ref.watch(personalInfoRepositoryProvider).getResumes();
    final contacts = ref.watch(personalInfoRepositoryProvider).getContacts();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Theme.of(context).colorScheme.tertiary, width: 2),
          ),
          child: const RemoteCircleAvatar(assetPath: 'assets/images/profile.png', radius: 100),
        ),
        Text(tr(ref, TranslationKeys.name), style: Theme.of(context).textTheme.displayLarge),
        gapH4,
        Text(tr(ref, TranslationKeys.description), style: Theme.of(context).textTheme.titleLarge),
        gapH8,
        Text(tr(ref, TranslationKeys.subDescription), style: Theme.of(context).textTheme.bodyLarge),
        _buildResumeButton(ref, resumes: resumes.toList()),
        gapH8,
        ContactBar(contacts: contacts.toList()),
      ],
    );
  }

  Widget _buildResumeButton(WidgetRef ref, {required List<Resume> resumes}) {
    if (resumes.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 36),
      child: ResumeButton(resumes: resumes),
    );
  }
}
