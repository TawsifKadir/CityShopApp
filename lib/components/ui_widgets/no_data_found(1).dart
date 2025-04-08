import 'package:flutter/material.dart';

import 'package:grs/components/ui_widgets/custom_sizebox.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/di.dart';
import 'package:grs/enum/enums.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/helpers/dimension_helper.dart';
import 'package:grs/library_widgets/svg_image.dart';
import 'package:grs/models/dummy/dimension.dart';
import 'package:grs/utils/assets.dart';
import 'package:grs/utils/text_styles.dart';

class NoDataFound extends StatelessWidget {
  final NoDataPref pref;
  const NoDataFound({required this.pref});

  @override
  Widget build(BuildContext context) {
    var data = _notFoundDescriptions();
    var imageWidth = sl<DimensionHelper>().dimensionSizer(Dimension(mobile: 140));
    var imageHeight = sl<DimensionHelper>().dimensionSizer(Dimension(mobile: 140));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgImage(image: Assets.not_found, width: imageWidth, height: imageHeight),
          const SizedBox(height: 16),
          Text(data['label'] ?? '', style: sl<TextStyles>().text16_600(black)),
          const SizedBox(height: 04),
          Text(data['desc'] ?? '', textAlign: TextAlign.center, style: sl<TextStyles>().text13_400(grey)),
          SizeBoxHeight(dimension: Dimension(mobile: 100, tab: 100)), // 60
        ],
      ),
    );
  }

  Map<String, String> _notFoundDescriptions() {
    var label = 'No Data Found'.translate;
    var desc = '';
    if (pref == NoDataPref.complains) {
      label = 'No complains Found'.translate;
      desc = '';
    } else if (pref == NoDataPref.history) {
      label = 'No complain history Found'.translate;
      desc = '';
    } else if (pref == NoDataPref.branch_officers) {
      label = 'No officers Found'.translate;
      desc = '';
    } else {
      label = 'No Data Found';
      desc = '';
    }
    return {'label': label, 'desc': desc};
  }
}
