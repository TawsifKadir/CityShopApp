import 'package:flutter/material.dart';

import 'package:grs/constants/colors.dart';
import 'package:grs/constants/shadows.dart';
import 'package:grs/core_widgets/pop_scope_navigator.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/route_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/utils/app_config.dart';
import 'package:grs/utils/keys.dart';
import 'package:grs/utils/text_styles.dart';
import 'package:grs/utils/transitions.dart';

Future<void> accountDeleteDialog() async {
  final context = navigatorKey.currentState!.context;
  await showGeneralDialog(
    context: context,
    barrierColor: popupBearer,
    barrierDismissible: false,
    transitionDuration: dialogDuration,
    barrierLabel: 'Account Delete Dialog',
    transitionBuilder: sl<Transitions>().bottomToTop,
    pageBuilder: (buildContext, anim1, anim2) {
      return PopScopeNavigator(canPop: false, child: Align(child: _AccountDeleteDialogView()));
    },
  );
}

class _AccountDeleteDialogView extends StatelessWidget {
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
    var label = 'Are you sure you want to delete your account and all information?'.translate;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, textAlign: TextAlign.center, style: sl<TextStyles>().text18_500(black)),
        const SizedBox(height: 24),
        Row(children: [Expanded(child: _noStayButton(context)), const SizedBox(width: 16), Expanded(child: _deleteButton(context))]),
      ],
    );
  }

  Widget _noStayButton(BuildContext context) {
    return OutlinedButton(
      onPressed: backToPrevious,
      child: Text('No, Stay'.translate, style: sl<TextStyles>().text18_500(grey)),
    );
  }

  Widget _deleteButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _deleteAccountOnTap(context),
      style: ElevatedButton.styleFrom(backgroundColor: red),
      child: Text('Yes, Delete'.translate, style: sl<TextStyles>().text18_500(white)),
    );
  }

  void _deleteAccountOnTap(BuildContext context) {
    backToPrevious();
    // sl<Routes>().loaderScreen(pref: LoaderScreenPref.delete_account).push();
  }
}
