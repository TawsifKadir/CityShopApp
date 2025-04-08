import 'package:flutter/material.dart';

import 'package:grs/constants/colors.dart';
import 'package:grs/library_widgets/svg_image.dart';
import 'package:grs/utils/assets.dart';

class CloseMenu extends StatelessWidget {
  final Function() onTap;
  const CloseMenu({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: onTap, icon: SvgImage(image: Assets.close, height: 22, width: 22, color: black));
  }
}
