import 'package:url_launcher/url_launcher.dart';

class LaunchUrlHelper {
  LaunchUrlHelper._();

  static Future<void> launchURL(String url) async {
    try {
      await launchUrl(Uri.parse(url));
    } catch (e) {
      // For utility classes, we use a generic error message or pass it from the caller
      throw 'Unable to open URL: $url';
    }
  }
}
