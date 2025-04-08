import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:grs/constants/colors.dart';
import 'package:grs/constants/shadows.dart';
import 'package:grs/core_widgets/modified_text_field.dart';
import 'package:grs/core_widgets/pop_scope_navigator.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/flutter_ext.dart';
import 'package:grs/extensions/route_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/libraries/toasts.dart';
import 'package:grs/models/complain/complain.dart';
import 'package:grs/utils/app_config.dart';
import 'package:grs/utils/keys.dart';
import 'package:grs/utils/text_styles.dart';
import 'package:grs/utils/transitions.dart';
import 'package:grs/view_models/complain_details/officer_complain_details_view_model.dart';

Future<void> appealDialog(Complain complain) async {
  final context = navigatorKey.currentState!.context;
  await showGeneralDialog(
    context: context,
    barrierColor: popupBearer,
    barrierDismissible: false,
    transitionDuration: dialogDuration,
    barrierLabel: 'Appeal Dialog',
    transitionBuilder: sl<Transitions>().bottomToTop,
    pageBuilder: (buildContext, anim1, anim2) {
      return PopScopeNavigator(canPop: false, child: Align(child: _AppealDialogView(complain)));
    },
  );
}

class _AppealDialogView extends StatefulWidget {
  final Complain complain;
  const _AppealDialogView(this.complain);

  @override
  State<_AppealDialogView> createState() => _AppealDialogViewState();
}

class _AppealDialogViewState extends State<_AppealDialogView> {
  var note = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    note.dispose();
    super.dispose();
  }

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
    var hint = 'Write your note here'.translate;
    var label = 'Are you sure you want to appeal?'.translate;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, textAlign: TextAlign.left, style: sl<TextStyles>().text20_500(black)),
        const SizedBox(height: 24),
        Text('Your Note'.translate, textAlign: TextAlign.center, style: sl<TextStyles>().text18_500(black)),
        const SizedBox(height: 06),
        ModifiedTextField(minLines: 06, maxLines: 10, controller: note, hintText: hint),
        const SizedBox(height: 24),
        Row(children: [Expanded(child: _closeButton(context)), const SizedBox(width: 16), Expanded(child: _appealButton(context))]),
      ],
    );
  }

  Widget _closeButton(BuildContext context) {
    return OutlinedButton(
      onPressed: backToPrevious,
      child: Text('Close'.translate, style: sl<TextStyles>().text18_500(grey)),
    );
  }

  Widget _appealButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _sendAppealOnTap(context),
      style: ElevatedButton.styleFrom(backgroundColor: primary),
      child: Text('Appeal'.translate, style: sl<TextStyles>().text18_500(white)),
    );
  }

  void _sendAppealOnTap(BuildContext context) {
    minimizeKeyboard();
    if (note.text.isEmpty) return sl<Toasts>().warningToast(message: 'Write your note here'.translate, isTop: true);
    backToPrevious();
    Provider.of<OfficerComplainDetailsViewModel>(context, listen: false).sendAppeal();
  }
}
