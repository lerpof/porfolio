import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portfolio/src/config/remote_asset_config.dart';

/// Service for managing remote assets (images and icons)
class RemoteAssetService {
  /// Get the full URL for an asset
  static String getAssetUrl(String assetPath) {
    return RemoteAssetConfig.getRemoteUrl(assetPath);
  }

  /// Create a NetworkImage with fallback
  static ImageProvider getNetworkImageProvider(String assetPath, {ImageProvider? fallback}) {
    if (!RemoteAssetConfig.shouldUseRemoteAssets()) {
      return AssetImage(assetPath);
    }

    try {
      return CachedNetworkImageProvider(getAssetUrl(assetPath));
    } catch (e) {
      debugPrint('Failed to load remote asset: $assetPath, error: $e');
      if (RemoteAssetConfig.enableFallback) {
        return fallback ?? AssetImage(assetPath);
      }
      return const AssetImage('assets/images/placeholder.png');
    }
  }

  /// Create a widget for remote images with loading and error states
  static Widget buildRemoteImage({required String assetPath, BoxFit? fit, double? width, double? height, Widget? placeholder, Widget? errorWidget}) {
    if (!RemoteAssetConfig.shouldUseRemoteAssets()) {
      return Image.asset(assetPath, fit: fit ?? BoxFit.cover, width: width, height: height, errorBuilder: (context, error, stackTrace) => errorWidget ?? const Icon(Icons.error));
    }

    return CachedNetworkImage(
      imageUrl: getAssetUrl(assetPath),
      fit: fit ?? BoxFit.cover,
      width: width,
      height: height,
      placeholder: (context, url) => placeholder ?? const CircularProgressIndicator(),
      errorWidget: (context, url, error) {
        if (RemoteAssetConfig.enableFallback) {
          return Image.asset(assetPath, fit: fit ?? BoxFit.cover, width: width, height: height, errorBuilder: (context, error, stackTrace) => errorWidget ?? const Icon(Icons.error));
        }
        return errorWidget ?? const Icon(Icons.error);
      },
    );
  }

  /// Create a widget for remote SVG icons
  static Widget buildRemoteSvg({required String assetPath, double? width, double? height, Color? color, Widget? placeholder, Widget? errorWidget}) {
    if (!RemoteAssetConfig.shouldUseRemoteAssets()) {
      return SvgPicture.asset(assetPath, width: width, height: height, colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null);
    }

    return SvgPicture.network(getAssetUrl(assetPath), width: width, height: height, colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null, placeholderBuilder: (context) => placeholder ?? const CircularProgressIndicator());
  }

  /// Preload remote images for better performance
  static Future<void> preloadRemoteImage(String assetPath, BuildContext context) async {
    try {
      await precacheImage(CachedNetworkImageProvider(getAssetUrl(assetPath)), context);
    } catch (e) {
      debugPrint('Failed to preload remote asset: $assetPath, error: $e');
    }
  }

  /// Batch preload multiple assets
  static Future<void> preloadRemoteAssets(List<String> assetPaths, BuildContext context) async {
    final futures = assetPaths.map((path) => preloadRemoteImage(path, context));
    await Future.wait(futures);
  }
}

/// Provider for remote asset service
final remoteAssetServiceProvider = Provider<RemoteAssetService>((ref) {
  return RemoteAssetService();
});

/// Helper widget for remote circular avatar
class RemoteCircleAvatar extends StatelessWidget {
  final String assetPath;
  final double radius;
  final Widget? placeholder;
  final Widget? errorWidget;

  const RemoteCircleAvatar({super.key, required this.assetPath, required this.radius, this.placeholder, this.errorWidget});

  @override
  Widget build(BuildContext context) {
    if (!RemoteAssetConfig.shouldUseRemoteAssets()) {
      return CircleAvatar(radius: radius, backgroundImage: AssetImage(assetPath));
    }

    return CircleAvatar(
      radius: radius,
      backgroundImage: RemoteAssetService.getNetworkImageProvider(assetPath),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: RemoteAssetService.getAssetUrl(assetPath),
          fit: BoxFit.cover,
          width: radius * 2,
          height: radius * 2,
          placeholder: (context, url) => placeholder ?? const CircularProgressIndicator(),
          errorWidget: (context, url, error) {
            if (RemoteAssetConfig.enableFallback) {
              return CircleAvatar(radius: radius, backgroundImage: AssetImage(assetPath));
            }
            return errorWidget ?? const Icon(Icons.person);
          },
        ),
      ),
    );
  }
}

/// Helper widget for remote project images with fade-in effect
class RemoteProjectImage extends StatelessWidget {
  final String assetPath;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;

  const RemoteProjectImage({super.key, required this.assetPath, this.fit = BoxFit.cover, this.placeholder, this.errorWidget});

  @override
  Widget build(BuildContext context) {
    if (!RemoteAssetConfig.shouldUseRemoteAssets()) {
      return Image.asset(assetPath, fit: fit, errorBuilder: (context, error, stackTrace) => errorWidget ?? const Placeholder());
    }

    return CachedNetworkImage(
      imageUrl: RemoteAssetService.getAssetUrl(assetPath),
      fit: fit,
      placeholder: (context, url) => placeholder ?? const CircularProgressIndicator(),
      errorWidget: (context, url, error) {
        if (RemoteAssetConfig.enableFallback) {
          return Image.asset(assetPath, fit: fit, errorBuilder: (context, error, stackTrace) => errorWidget ?? const Placeholder());
        }
        return errorWidget ?? const Placeholder();
      },
      fadeInDuration: const Duration(milliseconds: 300),
      fadeOutDuration: const Duration(milliseconds: 100),
    );
  }
}
