import 'package:flutter/material.dart';

import 'package:grs/constants/fonts.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/number_ext.dart';
import 'package:grs/helpers/dimension_helper.dart';
import 'package:grs/models/dummy/dimension.dart';

class TextStyles {
  TextStyle text26_600(Color color) {
    double fontSize = sl<DimensionHelper>().dimensionSizer(Dimension(mobile: 18.3.sp, tab: 26));
    return TextStyle(color: color, fontSize: fontSize, height: 1.46, fontWeight: w600, fontFamily: poppins);
  }

  TextStyle text22_600(Color color) {
    double fontSize = sl<DimensionHelper>().dimensionSizer(Dimension(mobile: 15.5.sp, tab: 22));
    return TextStyle(color: color, fontSize: fontSize, height: 1.45, fontWeight: w600, fontFamily: poppins);
  }

  TextStyle text22_500(Color color) {
    double fontSize = sl<DimensionHelper>().dimensionSizer(Dimension(mobile: 15.5.sp, tab: 22));
    return TextStyle(color: color, fontSize: fontSize, height: 1.45, fontWeight: w500, fontFamily: poppins);
  }

  TextStyle text20_600(Color color) {
    double fontSize = sl<DimensionHelper>().dimensionSizer(Dimension(mobile: 14.1.sp, tab: 20));
    return TextStyle(color: color, fontSize: fontSize, height: 1.50, fontWeight: w600, fontFamily: poppins);
  }

  TextStyle text20_500(Color color) {
    double fontSize = sl<DimensionHelper>().dimensionSizer(Dimension(mobile: 14.1.sp, tab: 20));
    return TextStyle(color: color, fontSize: fontSize, height: 1.50, fontWeight: w500, fontFamily: poppins);
  }

  TextStyle text18_600(Color color) {
    double fontSize = sl<DimensionHelper>().dimensionSizer(Dimension(mobile: 12.7.sp, tab: 18));
    return TextStyle(color: color, fontSize: fontSize, height: 1.44, fontWeight: w600, fontFamily: poppins);
  }

  TextStyle text18_500(Color color) {
    double fontSize = sl<DimensionHelper>().dimensionSizer(Dimension(mobile: 12.7.sp, tab: 18));
    return TextStyle(color: color, fontSize: fontSize, height: 1.44, fontWeight: w500, fontFamily: poppins);
  }

  TextStyle text18_400(Color color) {
    double fontSize = sl<DimensionHelper>().dimensionSizer(Dimension(mobile: 12.7.sp, tab: 18));
    return TextStyle(color: color, fontSize: fontSize, height: 1.44, fontWeight: normal, fontFamily: poppins);
  }

  TextStyle text17_600(Color color) {
    double fontSize = sl<DimensionHelper>().dimensionSizer(Dimension(mobile: 12.2.sp, tab: 17));
    return TextStyle(color: color, fontSize: fontSize, height: 1.44, fontWeight: w600, fontFamily: poppins);
  }

  TextStyle text17_400(Color color) {
    double fontSize = sl<DimensionHelper>().dimensionSizer(Dimension(mobile: 12.2.sp, tab: 17));
    return TextStyle(color: color, fontSize: fontSize, height: 1.44, fontWeight: normal, fontFamily: poppins);
  }

  TextStyle text16_800(Color color) {
    double fontSize = sl<DimensionHelper>().dimensionSizer(Dimension(mobile: 11.3.sp, tab: 16));
    return TextStyle(color: color, fontSize: fontSize, height: 1.62, fontWeight: w800, fontFamily: poppins);
  }

  TextStyle text16_600(Color color) {
    double fontSize = sl<DimensionHelper>().dimensionSizer(Dimension(mobile: 11.3.sp, tab: 16));
    return TextStyle(color: color, fontSize: fontSize, height: 1.62, fontWeight: w600, fontFamily: poppins);
  }

  TextStyle text16_500(Color color) {
    double fontSize = sl<DimensionHelper>().dimensionSizer(Dimension(mobile: 11.3.sp, tab: 16));
    return TextStyle(color: color, fontSize: fontSize, height: 1.62, fontWeight: w500, fontFamily: poppins);
  }

  TextStyle text16_400(Color color) {
    double fontSize = sl<DimensionHelper>().dimensionSizer(Dimension(mobile: 11.3.sp, tab: 16));
    return TextStyle(color: color, fontSize: fontSize, height: 1.62, fontWeight: normal, fontFamily: poppins);
  }

  TextStyle text15_700(Color color) {
    double fontSize = sl<DimensionHelper>().dimensionSizer(Dimension(mobile: 10.6.sp, tab: 15));
    return TextStyle(color: color, fontSize: fontSize, fontWeight: w700, fontFamily: poppins, height: 1.5);
  }

  TextStyle text15_600(Color color) {
    double fontSize = sl<DimensionHelper>().dimensionSizer(Dimension(mobile: 10.6.sp, tab: 15));
    return TextStyle(color: color, fontSize: fontSize, fontWeight: w600, fontFamily: poppins, height: 1.5);
  }

  TextStyle text15_800(Color color) {
    double fontSize = sl<DimensionHelper>().dimensionSizer(Dimension(mobile: 10.6.sp, tab: 15));
    return TextStyle(color: color, fontSize: fontSize, fontWeight: w800, fontFamily: poppins, height: 1.5);
  }

  TextStyle text15_400(Color color) {
    double fontSize = sl<DimensionHelper>().dimensionSizer(Dimension(mobile: 10.6.sp, tab: 15));
    return TextStyle(color: color, fontSize: fontSize, fontWeight: normal, fontFamily: poppins, height: 1.5);
  }

  TextStyle text15_500(Color color) {
    double fontSize = sl<DimensionHelper>().dimensionSizer(Dimension(mobile: 10.6.sp, tab: 15));
    return TextStyle(color: color, fontSize: fontSize, fontWeight: w500, fontFamily: poppins, height: 1.5);
  }

  TextStyle text14_600(Color color) {
    double fontSize = sl<DimensionHelper>().dimensionSizer(Dimension(mobile: 9.9.sp, tab: 14));
    return TextStyle(color: color, fontSize: fontSize, height: 1.42, fontWeight: w600, fontFamily: poppins);
  }

  TextStyle text14_500(Color color) {
    double fontSize = sl<DimensionHelper>().dimensionSizer(Dimension(mobile: 9.9.sp, tab: 14));
    return TextStyle(color: color, fontSize: fontSize, height: 1.42, fontWeight: w500, fontFamily: poppins);
  }

  TextStyle text14_400(Color color) {
    double fontSize = sl<DimensionHelper>().dimensionSizer(Dimension(mobile: 9.9.sp, tab: 14));
    return TextStyle(color: color, fontSize: fontSize, height: 1.42, fontWeight: normal, fontFamily: poppins);
  }

  TextStyle text13_500(Color color) {
    double fontSize = sl<DimensionHelper>().dimensionSizer(Dimension(mobile: 9.2.sp, tab: 13));
    return TextStyle(color: color, fontSize: fontSize, height: 1.53, fontWeight: w500, fontFamily: poppins);
  }

  TextStyle text13_400(Color color) {
    double fontSize = sl<DimensionHelper>().dimensionSizer(Dimension(mobile: 9.2.sp, tab: 13));
    return TextStyle(color: color, fontSize: fontSize, height: 1.53, fontWeight: normal, fontFamily: poppins);
  }

  TextStyle text12_500(Color color) {
    double fontSize = sl<DimensionHelper>().dimensionSizer(Dimension(mobile: 8.5.sp, tab: 12));
    return TextStyle(color: color, fontSize: fontSize, height: 1.5, fontWeight: w500, fontFamily: poppins);
  }

  TextStyle text12_400(Color color) {
    double fontSize = sl<DimensionHelper>().dimensionSizer(Dimension(mobile: 8.5.sp, tab: 12));
    return TextStyle(color: color, fontSize: fontSize, height: 1.5, fontWeight: normal, fontFamily: poppins);
  }
}
