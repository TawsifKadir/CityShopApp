import 'package:flutter/material.dart';

import 'package:grs/constants/colors.dart';
import 'package:grs/di.dart';
import 'package:grs/library_widgets/svg_image.dart';
import 'package:grs/utils/assets.dart';
import 'package:grs/utils/text_styles.dart';

class DateBox extends StatelessWidget {
  final bool haveDate;
  final String date;
  final Function() onTap;

  const DateBox({required this.haveDate, required this.date, required this.onTap});

  @override
  Widget build(BuildContext context) {
    var width = const SizedBox(width: 10);
    var borderRadius = BorderRadius.circular(6);
    var border = Border.all(color: grey40);
    var style = sl<TextStyles>().text14_400(haveDate ? black : grey80);
    var label = Flexible(child: Text(date, maxLines: 1, overflow: TextOverflow.ellipsis, style: style));
    var icon = SvgImage(image: Assets.calendar_outline, height: 24, color: haveDate ? grey80 : grey60);
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 48,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(borderRadius: borderRadius, border: border),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [label, width, icon]),
      ),
    );
  }
}
