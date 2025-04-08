import 'package:flutter/material.dart';

import 'package:grs/constants/colors.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/route_ext.dart';
import 'package:grs/library_widgets/circle_image.dart';
import 'package:grs/library_widgets/svg_image.dart';
import 'package:grs/service/routes.dart';
import 'package:grs/utils/assets.dart';

class ProfileImageMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var profile = sl<ProfileHelper>().profile;
    var errorImage = SvgImage(image: Assets.avatar_filled, fit: BoxFit.cover);
    // var loader = Center(child: Lottie.asset(Assets.imageLoader, height: 50, width: 50));
    return CircleImage(
      radius: 16,
      imageUrl: null,
      placeHolder: errorImage,
      borderColor: transparent,
      backgroundColor: transparent,
      errorWidget: Center(child: errorImage),
      onTap: () => sl<Routes>().profileScreen().push(),
    );
  }
}
