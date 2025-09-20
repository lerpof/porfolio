import 'package:collection/collection.dart';
import 'package:portfolio/src/localization/translation_helpers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portfolio/src/constants/sizes.dart';
import 'package:portfolio/src/features/project/data/project_repository.dart';
import 'package:portfolio/src/features/project/presentation/widgets/project_card.dart';
import 'package:portfolio/src/localization/translation_keys.dart';

class ProjectDesktop extends ConsumerWidget {
  const ProjectDesktop({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projects = ref.watch(projectRepositoryProvider).getProjects();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, bottom: 20),
          child: Text(tr(ref, TranslationKeys.projectsSectionTitle), style: Theme.of(context).textTheme.titleLarge),
        ),
        ...projects.mapIndexed((index, project) {
          return Column(
            children: [
              ProjectCard(project: project),
              if (index != projects.length - 1) gapH24,
            ],
          );
        }),
      ],
    );
  }
}
