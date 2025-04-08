import 'package:easy_localization/easy_localization.dart';

import 'package:grs/di.dart';
import 'package:grs/utils/reg_exps.dart';

extension ParseNumbers on String {
  int get parseInt => int.parse(this);
  double get parseDouble => double.parse(this);
  String get toLower => toLowerCase();
  String get toUpper => toUpperCase();
  String get translate => tr(this);
  String get removeHtml => replaceAll(RegExp('<[^>]*>', multiLine: true), '');
}

extension StringTexts on String? {
  String get toKey => this == null ? '' : this!.trim().toLower;
  bool get hasString => this == null ? false : this!.trim().length > 0;
  bool get isImageFile => this == null ? false : this == 'png' || this == 'jpg' || this == 'jpeg' || this == 'bmp';
  bool get isEnglish {
    if (this == null || this!.isEmpty) return true;
    if (sl<RegExps>().english.hasMatch(this!)) return true;
    return false;
  }
}

extension HrkString on String {
  String capitalize() {
    if (isEmpty) return '';
    String capitalizedString = this[0].toUpperCase();
    if (length > 1) capitalizedString += substring(1).toLowerCase();
    return capitalizedString;
  }

  String localizeDigits({required String toZeroDigit, String fromZeroDigit = '0'}) {
    assert(fromZeroDigit.length == 1);
    assert(toZeroDigit.length == 1);
    final localizedString = StringBuffer();
    for (int i = 0; i < length; i++) {
      final String char = this[i];
      if (char.codeUnitAt(0) >= fromZeroDigit.codeUnitAt(0) && char.codeUnitAt(0) <= fromZeroDigit.codeUnitAt(0) + 9) {
        int digit = char.codeUnitAt(0) - fromZeroDigit.codeUnitAt(0);
        localizedString.writeCharCode(toZeroDigit.codeUnitAt(0) + digit);
      } else {
        localizedString.write(char);
      }
    }
    return localizedString.toString();
  }

  /// Zero digits in some languages:
  /// | Language | Zero Digit | Unicode |
  /// | ---      | ---        | ---     |
  /// | Marathi  | ०          | \u0966  |
  /// | Bengali  | ০          | \u09e6  |
  /// | Kannada  | ೦          | \u0ce6  |
  /// | Arabic   | ٠          | \u0660  |
  /// | Persian  | ۰          | \u06f0  |

  /// References:
  /// - https://github.com/dart-lang/i18n/blob/main/pkgs/intl/lib/date_symbol_data_local.dart
  /// - https://github.com/flutter/flutter/blob/master/packages/flutter_localizations/lib/src/l10n/generated_date_localizations.dart
  /// - https://github.com/dart-lang/i18n/blob/main/pkgs/intl/lib/number_symbols_data.dart
}
