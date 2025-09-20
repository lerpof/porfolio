import 'dart:ui';

import 'package:intl/intl.dart';

extension LocalizedDate on int {
  String localizedYear(Locale locale) {
    final localeString = _getLocaleString(locale);
    return DateFormat.y(localeString).format(DateTime(this));
  }

  String localizedMonth(Locale locale) {
    final localeString = _getLocaleString(locale);
    return DateFormat.MMM(localeString).format(DateTime(0, this));
  }

  String _getLocaleString(Locale locale) {
    switch (locale.languageCode) {
      case 'it':
        return 'it_IT';
      case 'en':
      default:
        return 'en_US';
    }
  }
}
