import 'package:flutter/material.dart';

import 'package:grs/constants/colors.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/number_ext.dart';
import 'package:grs/library_widgets/svg_image.dart';
import 'package:grs/utils/assets.dart';
import 'package:grs/utils/size_config.dart';
import 'package:grs/utils/text_styles.dart';

class NoSupportView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var text1 = 'Oops!!';
    var text2 = 'GRS Officer app has no support for your tab or ipad.';
    var text3 = 'Please install in your mobile phone';
    return Container(
      width: SizeConfig.width,
      height: SizeConfig.height,
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgImage(image: Assets.contact_us, width: 50.width),
          const SizedBox(height: 24),
          Text('$text1\n$text2\n$text3', textAlign: TextAlign.center, style: sl<TextStyles>().text22_500(primary)),
        ],
      ),
    );
  }
}
