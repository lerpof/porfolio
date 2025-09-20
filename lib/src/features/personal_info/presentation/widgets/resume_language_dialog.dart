import 'package:collection/collection.dart';
import 'package:portfolio/src/localization/translation_helpers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portfolio/src/common/widgets/selection_area.dart';
import 'package:portfolio/src/features/personal_info/domain/resume.dart';
import 'package:portfolio/src/features/personal_info/presentation/widgets/resume_language_dialog_tile.dart';
import 'package:portfolio/src/localization/translation_keys.dart';

class ResumeLanguageDialog extends ConsumerWidget {
  const ResumeLanguageDialog({super.key, required this.resumes});

  final List<Resume> resumes;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SimpleDialog(
      title: MySelectionArea(child: Center(child: Text(tr(ref, TranslationKeys.downloadResume)))),
      titlePadding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 8.0),
      contentPadding: const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 40.0),
      children: [
        const Divider(height: 0),
        ...resumes.mapIndexed((index, resume) {
          return Column(
            children: [
              ResumeLanguageDialogTile(resume: resume),
              if (index != resumes.length) const Divider(height: 0),
            ],
          );
        }),
      ],
    );
  }
}
