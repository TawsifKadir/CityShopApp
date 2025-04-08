import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';

import 'package:grs/di.dart';
import 'package:grs/extensions/datetime_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/service/storage_service.dart';

class Formatters {
  // NumberFormat.currency().format(123456); // USD123,456.00
  // NumberFormat.currency(locale: 'eu').format(123456); // 123.456,00 EUR
  // NumberFormat.currency(name: 'EURO').format(123456); // EURO123,456.00
  // NumberFormat.currency(locale: 'eu', symbol: '?').format(123456); // 123.456,00 ?
  // NumberFormat.currency(locale: 'eu', decimalDigits: 3).format(123456); // 123.456,000 EUR
  // NumberFormat.currency(locale: 'eu', customPattern: '\u00a4 #,##.#').format(123456); // EUR 12.34.56,00

  String formatDecimalNumber(String value) {
    var formatter = NumberFormat.decimalPattern();
    return formatter.format(value.parseInt);
  }

  String localizeNumber(String? number) {
    if (number == null) return '';
    var language = sl<StorageService>().getLanguage;
    var locale = language == 'bn' ? 'bn_BD' : 'en_US';
    var formatter = NumberFormat.decimalPattern(locale);
    return formatter.format(number.parseInt);
  }

  String formatDate(String format, String? date) {
    if (date == null || date.isEmpty || date == 'null') return '';
    var language = sl<StorageService>().getLanguage;
    var locale = language == 'bn' ? 'bn_BN' : 'en_US';
    var formatter = DateFormat(format, locale);
    return formatter.format(date.parseDate);
  }

  String removeHtml(String? data) {
    if (data == null) return '';
    var updatedText = Bidi.stripHtmlIfNeeded(data);
    return updatedText.trim();
  }

  DateTime timeOfDayToDateTime(TimeOfDay time) {
    var now = DateTime.now();
    var dateTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return dateTime;
  }
}
