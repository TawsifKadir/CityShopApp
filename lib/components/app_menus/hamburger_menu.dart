import 'package:flutter/material.dart';

import 'package:grs/library_widgets/svg_image.dart';
import 'package:grs/utils/assets.dart';

class HamburgerMenu extends StatelessWidget {
  final Color color;
  final GlobalKey<ScaffoldState> scaffoldKey;
  const HamburgerMenu({required this.color, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => scaffoldKey.currentState!.openDrawer(),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: 4),
        child: SvgImage(image: Assets.hamburger, height: 24, fit: BoxFit.cover, color: color),
      ),
    );
  }
}
