import 'package:flutter/material.dart';

import 'package:grs/bottom_sheets/language_sheet.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/di.dart';
import 'package:grs/models/dummy/language.dart';
import 'package:grs/service/storage_service.dart';
import 'package:grs/utils/text_styles.dart';

class LanguageMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var language = _getLanguage();
    var minSize = const Size(50, 34);
    var maxSize = const Size(double.infinity, 34);
    var side = const BorderSide(color: grey80);
    var textStyle = sl<TextStyles>().text14_500(grey80);
    return OutlinedButton(
      child: Text(language.name),
      onPressed: languageBottomSheet,
      style: OutlinedButton.styleFrom(minimumSize: minSize, maximumSize: maxSize, side: side, textStyle: textStyle),
    );
  }

  Language _getLanguage() {
    var languageCode = sl<StorageService>().getLanguage;
    return allLanguages.firstWhere((item) => item.code == languageCode);
  }
}
