import 'package:flutter/material.dart';

import 'package:grs/constants/gradients.dart';
import 'package:grs/utils/size_config.dart';

class NavButtonBox extends StatelessWidget {
  final bool loader;
  final Widget child;
  const NavButtonBox({required this.loader, required this.child});

  @override
  Widget build(BuildContext context) {
    var padding = EdgeInsets.only(left: 24, right: 24, top: 16, bottom: SizeConfig.bottomNotch ? 24 : 16);
    const decoration = BoxDecoration(gradient: whiteGradient);
    return Opacity(
      opacity: loader ? 0.6 : 1,
      child: Container(child: child, padding: padding, width: double.infinity, decoration: decoration),
    );
  }
}
