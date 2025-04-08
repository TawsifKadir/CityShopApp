import 'package:flutter/material.dart';

import 'package:grs/components/ui_widgets/officer_action_popup_menu.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/di.dart';
import 'package:grs/enum/enums.dart';
import 'package:grs/extensions/list_ext.dart';
import 'package:grs/models/complain/complain.dart';
import 'package:grs/models/dummy/action_menu.dart';
import 'package:grs/service/storage_service.dart';

class ActionFloatingButton extends StatelessWidget {
  final bool loader;
  final ActionTypePref typePref;
  final Complain complain;

  const ActionFloatingButton({required this.loader, required this.complain, required this.typePref});

  @override
  Widget build(BuildContext context) {
    var actionMenus = typePref == ActionTypePref.appeal ? _appealActionMenus : _complainActionMenus;
    if (!actionMenus.haveList) return Container();
    return FloatingActionButton.extended(
      elevation: loader ? 0 : 1,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: loader ? primary.withOpacity(0.6) : primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      label: OfficerActionPopUpMenu(typePref: typePref, viewPref: ActionViewPref.details_view, onlyIcon: false, complain: complain),
      onPressed: () {},
    );
  }

  List<ActionMenu> get _appealActionMenus {
    var status = complain.currentStatus;
    if (status == 'APPEAL_GIVE_GUIDANCE') {
      return [start_investigation, close_complain];
    } else if (status == 'APPEAL' || status == 'APPEAL_STATEMENT_ANSWERED') {
      var isAnswered = status == 'APPEAL_STATEMENT_ANSWERED';
      return [subordinate_office_gro, start_investigation, if (isAnswered) provide_services, request_document, close_complain];
    } else if (status == 'INVESTIGATION_APPEAL') {
      return [request_document];
    } else if (status == 'INV_NOTICE_FILE') {
      return [investigation_report];
    } else if (status == 'APPEAL_IN_REVIEW') {
      return [provide_services, close_complain];
    } else {
      return [close_complain];
    }
  }

  List<ActionMenu> get _complainActionMenus {
    var status = complain.currentStatus;
    var test = status == 'FORWARDED_OUT';
    var isGro = sl<StorageService>().getUserType.toLowerCase() == 'gro';
    if (status == 'STATEMENT_ASKED' ||
        status == 'APPEAL_STATEMENT_ASKED' ||
        status == 'APPEAL_GIVE_GUIDANCE' ||
        (status == 'GIVE_GUIDANCE' && !isGro)) {
      return [give_opinion];
    } else if (status == 'PERMISSION_ASKED'){
      return [give_permission];
    } else if (status == 'INVESTIGATION' || status == 'INVESTIGATION_APPEAL') {
      return [request_document, hearing_notice];
    } else if (status == 'INV_NOTICE_FILE' || status == 'INV_NOTICE_FILE_APPEAL') {
      return [hearing_notice, investigation_report];
    } else if (status == 'INV_NOTICE_HEARING' || status == 'INV_NOTICE_HEARING_APPEAL') {
      return [take_hearing, investigation_report];
    } else if (status == 'INV_REPORT' || status == 'INV_REPORT_APPEAL') {
      return [if (!isGro) approve_disapprove, if (isGro) provide_services, if (isGro) close_complain];
    } else if (status == 'INV_HEARING' || status == 'INV_HEARING_APPEAL') {
      return [investigation_report, if ((status != 'NEW' || status == 'STATEMENT_ANSWERED') && status != 'GIVE_GUIDANCE') request_document];
    } else {
      return [
        if (status == 'NEW' || status == 'FORWARDED_OUT' || status == 'STATEMENT_ANSWERED' || status == 'PERMISSION_REPLIED') send_for_opinion,
        if (status == 'NEW' || status == 'FORWARDED_OUT') another_office,
        if (status == 'NEW' || status == 'FORWARDED_OUT') subordinate_office,
        if (status == 'NEW' || status == 'FORWARDED_OUT') to_appeal_officer,
        if (status == 'NEW' || status == 'FORWARDED_OUT' || status == 'STATEMENT_ANSWERED' || status == 'PERMISSION_REPLIED') subordinate_office_gro,
        if (status == 'NEW' || status == 'FORWARDED_OUT') reject,

        if ((status == 'STATEMENT_ANSWERED' || (status != 'NEW' && status != 'FORWARDED_OUT') || status == 'PERMISSION_REPLIED') && status != 'GIVE_GUIDANCE') provide_services,
        if (status == 'STATEMENT_ANSWERED' || (status != 'NEW' && status != 'FORWARDED_OUT') || status == 'PERMISSION_REPLIED') start_investigation,
        if ((status == 'STATEMENT_ANSWERED' || (status != 'NEW' && status != 'FORWARDED_OUT') || status == 'PERMISSION_REPLIED') && status != 'GIVE_GUIDANCE') request_document,
        if ((status == 'STATEMENT_ANSWERED' || (status != 'NEW' && status != 'FORWARDED_OUT')) && status != 'GIVE_GUIDANCE' && status != 'PERMISSION_REPLIED') send_for_permission,
        if (status == 'STATEMENT_ANSWERED' || (status != 'NEW' && status != 'FORWARDED_OUT') || status == 'PERMISSION_REPLIED') close_complain,

      ];
    }
  }
}
