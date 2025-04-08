import 'package:flutter/material.dart';

import 'package:grs/components/app_menus/close_menu.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/di.dart';
import 'package:grs/utils/text_styles.dart';

class SheetHeader extends StatelessWidget {
  final String title;
  final Function()? closeOnTap;
  const SheetHeader({required this.title, required this.closeOnTap});

  @override
  Widget build(BuildContext context) {
    var padding = const EdgeInsets.only(top: 24, left: 24, right: 24);
    var label = Text(title, style: sl<TextStyles>().text16_600(black));
    return Stack(
      children: [
        Container(width: double.infinity, alignment: Alignment.center, padding: padding, child: label),
        if (closeOnTap != null) Positioned(top: 16, right: 12, child: CloseMenu(onTap: closeOnTap!))
      ],
    );
  }
}
