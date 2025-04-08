import 'package:flutter/material.dart';

import 'package:grs/extensions/route_ext.dart';
import 'package:grs/library_widgets/svg_image.dart';
import 'package:grs/utils/assets.dart';

class BackMenu extends StatelessWidget {
  final Function()? onTap;
  const BackMenu({this.onTap});

  @override
  Widget build(BuildContext context) {
    var icon = SvgImage(image: Assets.arrow_left, height: 24, width: 24);
    return IconButton(padding: const EdgeInsets.only(left: 12), onPressed: onTap ?? backToPrevious, icon: icon);
  }
}
