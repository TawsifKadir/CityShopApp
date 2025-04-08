import 'package:flutter/material.dart';

import 'package:grs/constants/colors.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/route_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/library_widgets/svg_image.dart';
import 'package:grs/service/routes.dart';
import 'package:grs/utils/assets.dart';
import 'package:grs/utils/text_styles.dart';

class AddComplainButton extends StatelessWidget {
  final bool loader;
  AddComplainButton({required this.loader});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      elevation: loader ? 0 : 1,
      onPressed: loader ? null : sl<Routes>().addComplainScreen().push,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: loader ? primary.withOpacity(0.6) : primary,
      icon: SvgImage(image: Assets.plus, color: white, height: 26),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      label: Text('Add Complain'.translate, style: sl<TextStyles>().text16_500(white)),
    );
  }
}
