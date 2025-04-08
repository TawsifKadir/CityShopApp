import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

import 'package:grs/constants/colors.dart';
import 'package:grs/library_widgets/online_image.dart';
import 'package:grs/library_widgets/svg_image.dart';
import 'package:grs/utils/assets.dart';

class ProfileImage extends StatelessWidget {
  final String? image;
  final double box_size;
  final double image_size;
  const ProfileImage({required this.image, required this.box_size, required this.image_size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: box_size,
      height: box_size,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: grey.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
      child: OnlineImage(
        radius: 8,
        image: image,
        fit: BoxFit.cover,
        width: image_size,
        height: image_size,
        placeholder: Center(child: Lottie.asset(Assets.image_loader, height: 50, width: 50)),
        errorWidget: SvgImage(image: Assets.user_filled, width: 42.5, color: grey.withOpacity(0.65)),
      ),
    );
  }
}
