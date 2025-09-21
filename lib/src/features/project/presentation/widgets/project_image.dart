import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portfolio/src/constants/transparent_image.dart';
import 'package:portfolio/src/features/project/domain/project.dart';
import 'package:portfolio/src/common/widgets/icon.dart';
import 'package:portfolio/src/remote_assets.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;

class ProjectImage extends ConsumerWidget {
  const ProjectImage({super.key, required this.project, required this.isHovered});

  final Project project;
  final bool isHovered;

  static const double _iconSize = 36;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final minWidth = screenWidth < 640 ? screenWidth * 0.9 : (screenWidth < 1024 ? 400.0 : 520.0);
    final maxWidth = screenWidth < 640 ? screenWidth * 0.95 : (screenWidth < 1024 ? 500.0 : 600.0);

    return Stack(
      children: [
        Container(
          constraints: BoxConstraints(minHeight: 200, minWidth: minWidth, maxHeight: 400, maxWidth: maxWidth),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 4, color: Theme.of(context).colorScheme.tertiary.withAlpha(100)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                return AnimatedContainer(
                  foregroundDecoration: BoxDecoration(
                    gradient: LinearGradient(
                      tileMode: TileMode.decal,
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, isHovered ? Colors.black12 : Colors.transparent, isHovered ? Colors.black26 : Colors.transparent, isHovered ? Colors.black54 : Colors.transparent],
                    ),
                  ),
                  duration: const Duration(seconds: 1),
                  curve: Curves.decelerate,
                  transform: isHovered
                      ? (Matrix4.identity()
                          ..translateByVector3(Vector3(0.5 * width, 0.5 * width, 0))
                          ..scaleByVector3(Vector3(1.2, 1.2, 1.2))
                          ..translateByVector3(Vector3(0.5 * -width, 0.5 * -width, 0)))
                      : Matrix4.identity(),
                  child: _buildScreenshotImage(context),
                );
              },
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: SizedBox.square(
            dimension: _iconSize,
            child: AnimatedCrossFade(
              alignment: Alignment.center,
              firstCurve: Curves.decelerate,
              secondCurve: Curves.decelerate,
              sizeCurve: Curves.decelerate,
              crossFadeState: isHovered ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              duration: const Duration(seconds: 1),
              reverseDuration: const Duration(milliseconds: 500),
              firstChild: const SizedBox.shrink(),
              secondChild: MyIcon(icon: project.icon, size: _iconSize),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildScreenshotImage(BuildContext context) {
    final screenshotPath = project.screenshotPath;
    if (screenshotPath == null) return const Icon(Icons.code);

    return RemoteProjectImage(
      assetPath: screenshotPath,
      fit: BoxFit.cover,
      placeholder: FadeInImage(placeholder: MemoryImage(transparentImage), image: MemoryImage(transparentImage), fit: BoxFit.cover),
      errorWidget: const Placeholder(),
    );
  }
}
