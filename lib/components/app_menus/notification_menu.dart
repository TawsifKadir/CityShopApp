import 'package:flutter/material.dart';

import 'package:grs/constants/colors.dart';
import 'package:grs/library_widgets/svg_image.dart';
import 'package:grs/utils/assets.dart';

class NotificationMenu extends StatelessWidget {
  final int total;
  const NotificationMenu({required this.total});

  @override
  Widget build(BuildContext context) {
    var bellIcon = SvgImage(image: Assets.bell_filled, color: grey80, height: 28);
    const pointerChild = CircleAvatar(radius: 4, backgroundColor: amber);
    const pointer = CircleAvatar(radius: 6, backgroundColor: white, child: pointerChild);
    return InkWell(
      onTap: () {},
      child: Stack(children: [bellIcon, if (total > 0) const Positioned(top: 0, right: 1, child: pointer)]),
    );
  }
}
