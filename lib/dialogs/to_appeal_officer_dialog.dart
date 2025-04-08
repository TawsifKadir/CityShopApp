import 'package:flutter/material.dart';

import 'package:grs/constants/colors.dart';
import 'package:grs/constants/shadows.dart';
import 'package:grs/core_widgets/pop_scope_navigator.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/number_ext.dart';
import 'package:grs/extensions/route_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/library_widgets/svg_image.dart';
import 'package:grs/utils/app_config.dart';
import 'package:grs/utils/assets.dart';
import 'package:grs/utils/keys.dart';
import 'package:grs/utils/text_styles.dart';
import 'package:grs/utils/transitions.dart';

Future<void> toAppealOfficerDialog() async {
  final context = navigatorKey.currentState!.context;
  await showGeneralDialog(
    context: context,
    barrierColor: popupBearer,
    barrierDismissible: false,
    transitionDuration: dialogDuration,
    barrierLabel: 'To Appeal Officer Dialog',
    transitionBuilder: sl<Transitions>().bottomToTop,
    pageBuilder: (buildContext, anim1, anim2) {
      return PopScopeNavigator(canPop: false, child: Align(child: _ToAppealOfficerDialogView()));
    },
  );
}

class _ToAppealOfficerDialogView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: dialogWidth,
      padding: EdgeInsets.symmetric(horizontal: dialogPadding, vertical: dialogPadding),
      decoration: BoxDecoration(color: white, borderRadius: dialogRadius, boxShadow: const [popupShadow]),
      child: Material(color: white, borderRadius: dialogRadius, child: _mobileView(context)),
    );
  }

  Widget _mobileView(BuildContext context) {
    var size = Size(45.width, 50);
    var buttonLabel = Text('Okey'.translate, style: sl<TextStyles>().text18_500(white));
    var buttonStyle = ElevatedButton.styleFrom(backgroundColor: primary, maximumSize: size, minimumSize: size);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(child: SvgImage(image: Assets.check_circle_outline, color: amber, height: 18.width)),
        const SizedBox(height: 16),
        Text(
          'Appeal sent to appeal officer successfully'.translate,
          textAlign: TextAlign.center,
          style: sl<TextStyles>().text18_500(black),
        ),
        // const SizedBox(height: 06),
        // _dataBox(label: '', value: ''),
        const SizedBox(height: 24),
        ElevatedButton(style: buttonStyle, child: buttonLabel, onPressed: backToPrevious)
      ],
    );
  }

  /*Widget _dataBox({required String label, required String value}) {
    return Row(
      children: [
        SizedBox(width: 125, child: Text('Appeal Officer:', style: sl<TextStyles>().text16_500(black))),
        const SizedBox(width: 04),
        Expanded(child: Text('Appeal Officer:', style: sl<TextStyles>().text16_500(black))),
      ],
    );
  }*/
}
