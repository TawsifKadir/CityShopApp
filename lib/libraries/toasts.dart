import 'package:fluttertoast/fluttertoast.dart';

import 'package:grs/constants/colors.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/number_ext.dart';
import 'package:grs/helpers/dimension_helper.dart';
import 'package:grs/models/dummy/dimension.dart';

class Toasts {
  void toastMessage({required String message, required bool isTop}) {
    double fontSize = sl<DimensionHelper>().dimensionSizer(Dimension(mobile: 11.3.sp, tab: 16));
    Fluttertoast.showToast(
      msg: message,
      textColor: white,
      fontSize: fontSize,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: black.withOpacity(0.8),
      gravity: isTop ? ToastGravity.TOP : ToastGravity.BOTTOM,
    );
  }

  void successToast({required String message, required bool isTop}) {
    double fontSize = sl<DimensionHelper>().dimensionSizer(Dimension(mobile: 11.3.sp, tab: 16));
    Fluttertoast.showToast(
      msg: message,
      textColor: white,
      fontSize: fontSize,
      backgroundColor: primary,
      toastLength: Toast.LENGTH_LONG,
      gravity: isTop ? ToastGravity.TOP : ToastGravity.BOTTOM,
    );
  }

  void warningToast({required String message, required bool isTop}) {
    double fontSize = sl<DimensionHelper>().dimensionSizer(Dimension(mobile: 11.3.sp, tab: 16));
    Fluttertoast.showToast(
      msg: message,
      textColor: white,
      fontSize: fontSize,
      backgroundColor: amber,
      toastLength: Toast.LENGTH_LONG,
      gravity: isTop ? ToastGravity.TOP : ToastGravity.BOTTOM,
    );
  }

  void errorToast({required String message, required bool isTop}) {
    double fontSize = sl<DimensionHelper>().dimensionSizer(Dimension(mobile: 11.3.sp, tab: 16));
    Fluttertoast.showToast(
      msg: message,
      textColor: white,
      fontSize: fontSize,
      backgroundColor: red,
      toastLength: Toast.LENGTH_LONG,
      gravity: isTop ? ToastGravity.TOP : ToastGravity.BOTTOM,
    );
  }
}
