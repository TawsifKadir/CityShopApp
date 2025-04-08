import 'dart:async';

import 'package:flutter/material.dart';

import 'package:grs/constants/colors.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/datetime_ext.dart';
import 'package:grs/extensions/flutter_ext.dart';
import 'package:grs/libraries/formatters.dart';
import 'package:grs/library_widgets/svg_image.dart';
import 'package:grs/service/storage_service.dart';
import 'package:grs/utils/assets.dart';
import 'package:grs/utils/text_styles.dart';

class DatePickerView extends StatelessWidget {
  final String hint;
  final bool showPicker;
  final String dateFormat;
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime? initialDate;
  final Function(DateTime) onChanged;

  const DatePickerView({
    required this.hint,
    required this.firstDate,
    required this.lastDate,
    required this.showPicker,
    required this.dateFormat,
    required this.initialDate,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    var width = const SizedBox(width: 10);
    var border = Border.all(color: grey60);
    var borderRadius = BorderRadius.circular(6);
    var style = sl<TextStyles>().text14_400(initialDate == null ? grey80 : black);
    var date = initialDate == null ? hint : sl<Formatters>().formatDate(dateFormat, '$initialDate');
    var label = Flexible(child: Text(date, maxLines: 1, overflow: TextOverflow.ellipsis, style: style));
    var icon = SvgImage(image: Assets.calendar_outline, height: 24, color: grey80);
    return InkWell(
      onTap: initialDate != null && !showPicker ? null : () => _showDatePicker(context),
      child: Container(
        height: 48,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 13),
        decoration: BoxDecoration(color: white, borderRadius: borderRadius, border: border),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [label, width, icon]),
      ),
    );
  }

  Future<void> _showDatePicker(BuildContext context) async {
    var language = sl<StorageService>().getLanguage;
    await minimizeKeyboard();
    var picked = await showDatePicker(
      context: context,
      lastDate: lastDate,
      firstDate: firstDate,
      locale: Locale(language),
      currentDate: currentDate,
      initialDate: initialDate ?? currentDate,
      builder: (context, child) => _datePickerTheme(context: context, child: child),
    );
    if (picked != null) onChanged(picked);
  }

  Theme _datePickerTheme({required BuildContext context, required Widget? child}) {
    // const scheme = ColorScheme.light(primary: primary, surface: primary, onSurface: black);
    return Theme(child: child!, data: ThemeData.light().copyWith(dialogBackgroundColor: white, disabledColor: grey40));
  }
}
