import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

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
import 'package:grs/view_models/global_view_model.dart';

Future<void> logoutDialog() async {
  final context = navigatorKey.currentState!.context;
  await showGeneralDialog(
    context: context,
    barrierColor: popupBearer,
    barrierDismissible: false,
    barrierLabel: 'Logout Dialog',
    transitionDuration: dialogDuration,
    transitionBuilder: sl<Transitions>().fadeTransaction,
    pageBuilder: (buildContext, anim1, anim2) {
      return PopScopeNavigator(canPop: false, child: Align(child: _LogoutDialogView()));
    },
  );
}

class _LogoutDialogView extends StatelessWidget {
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
    var label = 'Are you sure you want to log out from your account?'.translate;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, textAlign: TextAlign.center, style: sl<TextStyles>().text18_500(black)),
        const SizedBox(height: 24),
        Row(children: [Expanded(child: _noStayButton(context)), const SizedBox(width: 16), Expanded(child: _logoutButton(context))]),
      ],
    );
  }

  Widget _noStayButton(BuildContext context) {
    return OutlinedButton(
      onPressed: backToPrevious,
      child: Text('No, Stay'.translate, style: sl<TextStyles>().text18_500(grey)),
    );
  }

  Widget _logoutButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Provider.of<GlobalViewModel>(context, listen: false).logoutUser(),
      child: Text('Yes, Logout'.translate, style: sl<TextStyles>().text18_500(white)),
    );
  }
}
