import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:grs/components/ui_widgets/sheet_header.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/core_widgets/modified_text_field.dart';
import 'package:grs/core_widgets/pop_scope_navigator.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/route_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/libraries/toasts.dart';
import 'package:grs/models/complain/complain_details_api.dart';
import 'package:grs/utils/app_config.dart';
import 'package:grs/utils/keys.dart';
import 'package:grs/utils/text_styles.dart';
import 'package:grs/view_models/complain_details/officer_complain_details_view_model.dart';

Future<void> addBlacklistBottomSheet(ComplainDetailsApi complainDetails) async {
  var context = navigatorKey.currentState!.context;
  await showModalBottomSheet(
    context: context,
    isDismissible: false,
    shape: bottomSheetShape,
    isScrollControlled: true,
    clipBehavior: Clip.antiAlias,
    builder: (builder) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: PopScopeNavigator(canPop: false, child: _AddBlacklistSheetView(complainDetails)),
      );
    },
  );
}

class _AddBlacklistSheetView extends StatefulWidget {
  final ComplainDetailsApi complainDetails;
  const _AddBlacklistSheetView(this.complainDetails);

  @override
  State<_AddBlacklistSheetView> createState() => _AddBlacklistSheetViewState();
}

class _AddBlacklistSheetViewState extends State<_AddBlacklistSheetView> {
  var reason = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var label = Text('Set Blacklist'.translate, style: sl<TextStyles>().text18_500(white));
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SheetHeader(title: 'Blacklist'.translate, closeOnTap: backToPrevious),
        const SizedBox(height: 24),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 24), child: _complainInfo(context)),
        const SizedBox(height: 32),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ElevatedButton(onPressed: () => _blacklistOnTap(context), child: label),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  void _blacklistOnTap(BuildContext context) {
    var message = 'Please write a reason for blacklist'.translate;
    if (reason.text.trim().length < 1) return sl<Toasts>().warningToast(message: message, isTop: true);
    var body = _addAsBlacklistBody();
    var viewmodel = Provider.of<OfficerComplainDetailsViewModel>(context, listen: false);
    viewmodel.addAsBlacklist(body);
    backToPrevious();
  }

  Widget _complainInfo(BuildContext context) {
    var test = 'Write your note here'.translate;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Black List Reason'.translate, style: sl<TextStyles>().text16_400(black)),
        const SizedBox(height: 6),
        ModifiedTextField(minLines: 06, maxLines: 12, controller: reason, hintText: test),
      ],
    );
  }

  Map<String, String> _addAsBlacklistBody(){
    var officeId = widget.complainDetails.complain?.officeId;
    var officeName = widget.complainDetails.office?.office_name;
    var complaintId = widget.complainDetails.complain?.complainantId;
    var reasonText = reason.text;

    Map<String, String> bodyInformation = {};
    if (complaintId != null) bodyInformation['complainant_id'] = '$complaintId';
    if (officeId != null) bodyInformation['office_id'] = '$officeId';
    if (officeName!.isNotEmpty) bodyInformation['office_name'] = officeName;
    if (reasonText.isNotEmpty) bodyInformation['reason'] = reasonText;

    return bodyInformation;
  }
}
