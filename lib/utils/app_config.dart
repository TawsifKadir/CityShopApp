import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:grs/constants/colors.dart';
import 'package:grs/extensions/number_ext.dart';
import 'package:grs/utils/size_config.dart';

/// Durations
const dialogDuration = Duration(milliseconds: 700);
const popDuration = Duration(milliseconds: 300);

/// Dimensions
const appbarAction = 24.0;
double get screenPadding => 24;
double get dialogPadding => 24;
double get dialogWidth => SizeConfig.width - 48;
BorderRadius get dialogRadius => BorderRadius.circular(08);
double get drawerWidth => 48.widthRatio;
RoundedRectangleBorder bottomSheetShape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(16));

Size get button52Small => const Size(50, 52);
Size get button52Large => const Size(double.infinity, 52);
Size get button48Small => const Size(50, 48);
Size get button48Large => const Size(double.infinity, 48);

Future<void> portraitMode() => SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

/// Appbar
const overlayStyle = SystemUiOverlayStyle(
  statusBarColor: primary,
  systemNavigationBarColor: black,
  statusBarBrightness: Brightness.light,
  statusBarIconBrightness: Brightness.dark,
  systemNavigationBarIconBrightness: Brightness.dark,
);
