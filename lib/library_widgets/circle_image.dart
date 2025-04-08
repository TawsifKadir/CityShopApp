import 'dart:core';

import 'package:flutter/material.dart';

import 'package:grs/constants/colors.dart';
import 'package:grs/library_widgets/online_image.dart';

class CircleImage extends StatelessWidget {
  final Function()? onTap;
  final String? imageUrl;
  final double radius;
  final double? elevation;
  final double? borderWidth;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Widget? placeHolder;
  final Widget? errorWidget;
  final BoxFit? imageFit;

  const CircleImage({
    required this.imageUrl,
    this.radius = 50,
    this.elevation = 0,
    this.borderWidth = 0,
    this.borderColor = white,
    this.backgroundColor = white,
    this.imageFit = BoxFit.cover,
    this.foregroundColor = transparent,
    this.onTap,
    this.placeHolder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    var borderRadius = BorderRadius.circular(radius);
    var border = Border.all(width: borderWidth ?? 0, color: borderColor ?? white);
    return InkWell(
      onTap: onTap,
      child: Material(
        color: borderColor,
        elevation: elevation ?? 0,
        type: MaterialType.circle,
        child: Container(
          width: radius * 2,
          height: radius * 2,
          alignment: Alignment.center,
          decoration: BoxDecoration(borderRadius: borderRadius, border: border),
          child: Container(
            decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(radius)),
            child: Stack(fit: StackFit.expand, children: <Widget>[_profileImage(context)]),
          ),
        ),
      ),
    );
  }

  Widget _profileImage(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child:
          imageUrl == null ? errorWidget : OnlineImage(fit: imageFit, image: imageUrl!, placeholder: placeHolder, errorWidget: errorWidget),
    );
  }
}
