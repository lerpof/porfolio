import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portfolio/src/localization/translation_helpers.dart';
import 'package:portfolio/src/localization/translation_keys.dart';

class AboutDesktop extends ConsumerWidget {
  const AboutDesktop({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 32),
          child: Text(tr(ref, TranslationKeys.aboutSectionTitleAlt), style: Theme.of(context).textTheme.titleLarge),
        ),
        Text(tr(ref, TranslationKeys.aboutDescription), style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}
