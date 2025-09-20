import 'package:portfolio/src/localization/translation_helpers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portfolio/src/common/widgets/selection_area.dart';
import 'package:portfolio/src/features/general/provider/scroll_controller.dart';
import 'package:portfolio/src/localization/translation_keys.dart';

class BottomBanner extends ConsumerStatefulWidget {
  const BottomBanner({super.key});

  @override
  ConsumerState<BottomBanner> createState() => _BottomBannerState();
}

class _BottomBannerState extends ConsumerState<BottomBanner> {
  double _height = 0;

  void _displayBottomBanner() {
    final scrollController = ref.watch(scrollControllerProvider);
    final scrollPosition = scrollController.position;
    if (scrollPosition.pixels >= scrollPosition.maxScrollExtent - 64) {
      setState(() => _height = kBottomNavigationBarHeight);
    } else {
      setState(() => _height = 0);
    }
  }

  @override
  void didChangeDependencies() {
    ref.watch(scrollControllerProvider).addListener(_displayBottomBanner);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: double.maxFinite,
      height: _height,
      color: Theme.of(context).colorScheme.secondary,
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.titleSmall!,
        child: MySelectionArea(
          child: Center(
            child: Text.rich(
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              TextSpan(children: [TextSpan(text: "${tr(ref, TranslationKeys.bottomBannerMessage)} ")]),
            ),
          ),
        ),
      ),
    );
  }

  // void _onTap(BuildContext context, {required String url}) async {
  //   try {
  //     await LaunchUrlHelper.launchURL(url);
  //   } catch (e) {
  //     if (!context.mounted) return;
  //     ScaffoldMessengerHelper.showLaunchUrlError(context, url: url);
  //   }
  // }
}
