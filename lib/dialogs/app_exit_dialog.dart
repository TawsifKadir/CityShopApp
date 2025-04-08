import 'dart:io' as platform;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

dynamic appExitDialog() async {
  final context = navigatorKey.currentState!.context;
  await showGeneralDialog(
    context: context,
    barrierColor: popupBearer,
    barrierDismissible: false,
    barrierLabel: 'App Exit Dialog',
    transitionDuration: dialogDuration,
    transitionBuilder: sl<Transitions>().topToBottom,
    pageBuilder: (buildContext, anim1, anim2) {
      return PopScopeNavigator(canPop: false, child: Align(child: _AppExitDialogView()));
    },
  );
}

class _AppExitDialogView extends StatelessWidget {
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
    var label = 'Are you sure you want to close GRS?'.translate;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, textAlign: TextAlign.center, style: sl<TextStyles>().text18_500(black)),
        const SizedBox(height: 24),
        Row(children: [Expanded(child: _noStayButton(context)), const SizedBox(width: 16), Expanded(child: _appExitButton(context))]),
      ],
    );
  }

  Widget _noStayButton(BuildContext context) {
    return OutlinedButton(
      onPressed: backToPrevious,
      child: Text('No, Stay'.translate, style: sl<TextStyles>().text18_500(grey)),
    );
  }

  Widget _appExitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => platform.Platform.isAndroid ? SystemNavigator.pop() : platform.exit(0),
      child: Text('Yes, Please'.translate, style: sl<TextStyles>().text18_500(white)),
    );
  }
}
