import 'package:flutter/material.dart';

import 'package:grs/constants/colors.dart';
import 'package:grs/library_widgets/svg_image.dart';
import 'package:grs/utils/assets.dart';

class AddButton extends StatelessWidget {
  final Function() onTap;
  const AddButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    var center = Alignment.center;
    var icon = SvgImage(image: Assets.plus, color: primary, height: 20, fit: BoxFit.contain);
    var decoration = BoxDecoration(color: primary.withOpacity(0.1), borderRadius: BorderRadius.circular(4));
    return InkWell(onTap: onTap, child: Container(height: 30, width: 30, decoration: decoration, alignment: center, child: icon));
  }
}
