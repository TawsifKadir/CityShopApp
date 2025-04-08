import 'package:grs/models/dummy/dimension.dart';
import 'package:grs/utils/keys.dart';
import 'package:grs/utils/size_config.dart';

class DimensionHelper {
  double dimensionSizer(Dimension dimension) {
    var context = navigatorKey.currentState?.context;
    if (context == null) return dimension.mobile;
    var screenWidth = SizeConfig.width;
    if (screenWidth < 1) return dimension.mobile;
    if (screenWidth <= 375) {
      return dimension.mobile;
    } else if (screenWidth > 375 && screenWidth < 601) {
      return dimension.mobile;
    } else if (screenWidth >= 601 && screenWidth < 1024) {
      return dimension.tab ?? 0;
    } else {
      return dimension.tab ?? 0;
    }
  }
}
