import 'package:flutter/material.dart';

import 'package:grs/components/ui_widgets/no_officer_view.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/di.dart';
import 'package:grs/library_widgets/svg_image.dart';
import 'package:grs/models/branch/officer.dart';
import 'package:grs/utils/assets.dart';
import 'package:grs/utils/text_styles.dart';

class SelectedOfficerView extends StatelessWidget {
  final Officer? selectedOfficer;
  const SelectedOfficerView({required this.selectedOfficer});

  @override
  Widget build(BuildContext context) {
    if (selectedOfficer == null) return NoOfficerSelectedView();
    var border = Border.all(color: grey60);
    var radius = BorderRadius.circular(6);
    var icon = SvgImage(image: Assets.user_filled, color: grey80, height: 20);
    var name = selectedOfficer?.label ?? '';
    var label = Text(name, maxLines: 2, overflow: TextOverflow.ellipsis, style: sl<TextStyles>().text16_400(black));
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(border: border, color: white, borderRadius: radius),
      child: Row(children: [icon, const SizedBox(width: 12), Expanded(child: label)]),
    );
  }
}
