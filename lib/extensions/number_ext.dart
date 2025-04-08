import 'package:grs/utils/size_config.dart';

extension NumberExt on num {
  double get height => this * (SizeConfig.height / 100);
  double get width => this * (SizeConfig.width / 100);
  double get sp => this * ((SizeConfig.width / 3) / 100);
  double get widthRatio => this * ((SizeConfig.isPortrait ? SizeConfig.width : SizeConfig.height) / 100);
}
