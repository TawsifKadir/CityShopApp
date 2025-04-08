import 'package:flutter/material.dart';

import 'package:month_picker_dialog/month_picker_dialog.dart';

import 'package:grs/constants/colors.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/datetime_ext.dart';
import 'package:grs/library_widgets/svg_image.dart';
import 'package:grs/service/storage_service.dart';
import 'package:grs/utils/assets.dart';
import 'package:grs/utils/size_config.dart';

class CalendarMenu extends StatelessWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime? initialDate;
  final Function(DateTime) onChanged;
  const CalendarMenu({required this.firstDate, required this.lastDate, required this.initialDate, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    var icon = SvgImage(image: Assets.calendar_outline, height: 28, width: 28, color: black);
    return InkWell(
      onTap: () => _showDatePicker(context),
      child: Container(width: 30, height: 30, alignment: Alignment.center, child: icon),
    );
  }

  Future<void> _showDatePicker(BuildContext context) async {
    var language = sl<StorageService>().getLanguage;
    var picked = await showMonthPicker(
      context: context,
      lastDate: lastDate,
      firstDate: firstDate,
      headerColor: primary,
      locale: Locale(language),
      customWidth: SizeConfig.width - 20,
      initialDate: initialDate ?? DateTime(currentDate.year, currentDate.month),
    );
    if (picked != null) onChanged(picked);
  }
}
