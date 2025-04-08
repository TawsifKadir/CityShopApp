import 'package:flutter/material.dart';

import 'package:grs/constants/colors.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/library_widgets/svg_image.dart';
import 'package:grs/utils/assets.dart';
import 'package:grs/utils/text_styles.dart';

class NoAttachmentsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var border = Border.all(color: grey80);
    var radius = BorderRadius.circular(6);
    var message = 'No previous attachments available'.translate;
    var icon = SvgImage(image: Assets.info_outline, color: black, height: 20);
    var label = Text(message, style: sl<TextStyles>().text14_400(black));
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(border: border, color: cardShade.withOpacity(0.03), borderRadius: radius),
      child: Row(children: [icon, const SizedBox(width: 10), Expanded(child: label)]),
    );
  }
}
