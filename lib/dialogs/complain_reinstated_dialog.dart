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

Future<void> complainReinstatedDialog() async {
  final context = navigatorKey.currentState!.context;
  await showGeneralDialog(
    context: context,
    barrierColor: popupBearer,
    barrierDismissible: false,
    transitionDuration: dialogDuration,
    barrierLabel: 'Complain Reinstated Dialog',
    transitionBuilder: sl<Transitions>().bottomToTop,
    pageBuilder: (buildContext, anim1, anim2) {
      return PopScopeNavigator(canPop: false, child: Align(child: _ComplainReinstatedDialogView()));
    },
  );
}

class _ComplainReinstatedDialogView extends StatelessWidget {
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(child: SvgImage(image: Assets.info_outline, color: amber, height: 18.width)),
        const SizedBox(height: 16),
        Text('Are you sure?'.translate, textAlign: TextAlign.center, style: sl<TextStyles>().text18_500(black)),
        const SizedBox(height: 06),
        Text('The complaint will be reinstated'.translate, textAlign: TextAlign.center, style: sl<TextStyles>().text18_500(black)),
        const SizedBox(height: 24),
        Row(children: [Expanded(child: _noButton(context)), const SizedBox(width: 16), Expanded(child: _yesButton(context))]),
      ],
    );
  }

  Widget _noButton(BuildContext context) {
    return OutlinedButton(
      onPressed: backToPrevious,
      child: Text('No'.translate, style: sl<TextStyles>().text18_500(grey)),
    );
  }

  Widget _yesButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _deleteAccountOnTap(context),
      style: ElevatedButton.styleFrom(backgroundColor: primary),
      child: Text('Yes'.translate, style: sl<TextStyles>().text18_500(white)),
    );
  }

  void _deleteAccountOnTap(BuildContext context) {
    backToPrevious();
    // sl<Routes>().loaderScreen(pref: LoaderScreenPref.delete_account).push();
  }
}
