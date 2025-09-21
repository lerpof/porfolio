/// Configuration for remote assets
/// Update these URLs to point to your actual CDN or cloud storage
class RemoteAssetConfig {
  // Base URL for your remote assets
  static const String baseUrl = 'https://firebasestorage.googleapis.com/v0/b/flutter-portfolio-74db1.firebasestorage.app/o/portfolio-assets%2F';

  // Flag to enable/disable remote assets (useful for development)
  static const bool useRemoteAssets = true;

  // Fallback for when remote assets fail to load
  static const bool enableFallback = true;

  // Cache duration for remote images
  static const Duration cacheDuration = Duration(days: 7);

  // Asset categories and their remote paths
  static const Map<String, String> assetCategories = {'images': 'images', 'icons': 'icons'};

  /// Get the complete remote URL for an asset
  static String getRemoteUrl(String localAssetPath) {
    final cleanPath = localAssetPath.replaceFirst('assets/', '');
    return '$baseUrl/$cleanPath';
  }

  /// Check if we should use remote assets
  static bool shouldUseRemoteAssets() {
    return useRemoteAssets;
  }
}
