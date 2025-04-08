import 'dart:async';

import 'package:flutter/material.dart';

import 'package:grs/constants/colors.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/flutter_ext.dart';
import 'package:grs/libraries/formatters.dart';
import 'package:grs/library_widgets/svg_image.dart';
import 'package:grs/utils/assets.dart';
import 'package:grs/utils/text_styles.dart';

class TimePickerView extends StatelessWidget {
  final String hint;
  final bool showPicker;
  final String timeFormat;
  final TimeOfDay? initialTime;
  final Function(TimeOfDay) onChanged;

  const TimePickerView({
    required this.hint,
    required this.showPicker,
    required this.timeFormat,
    required this.initialTime,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    var width = const SizedBox(width: 10);
    var border = Border.all(color: grey60);
    var borderRadius = BorderRadius.circular(6);
    var style = sl<TextStyles>().text14_400(initialTime == null ? grey80 : black);
    var label = Flexible(child: Text(_getFormatTime, maxLines: 1, overflow: TextOverflow.ellipsis, style: style));
    var icon = SvgImage(image: Assets.clock_outline, height: 24, color: grey80);
    return InkWell(
      onTap: initialTime != null && !showPicker ? null : () => _showTimePicker(context),
      child: Container(
        height: 48,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 13),
        decoration: BoxDecoration(color: white, borderRadius: borderRadius, border: border),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [label, width, icon]),
      ),
    );
  }

  String get _getFormatTime {
    if (initialTime == null) return hint;
    var datetime = sl<Formatters>().timeOfDayToDateTime(initialTime!);
    return sl<Formatters>().formatDate(timeFormat, '$datetime');
  }

  Future<void> _showTimePicker(BuildContext context) async {
    await minimizeKeyboard();
    var picked = await showTimePicker(
        context: context,
        initialTime: initialTime ?? TimeOfDay.now(),
        builder: (context, child) {
          return MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false), child: child!);
        });

    if (picked != null) onChanged(picked);
  }
}
