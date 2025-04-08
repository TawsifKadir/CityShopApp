import 'package:flutter/material.dart';

import 'package:grs/constants/colors.dart';
import 'package:grs/di.dart';
import 'package:grs/enum/enums.dart';
import 'package:grs/extensions/list_ext.dart';
import 'package:grs/extensions/route_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/models/complain/complain.dart';
import 'package:grs/models/dummy/action_menu.dart';
import 'package:grs/service/routes.dart';
import 'package:grs/service/storage_service.dart';
import 'package:grs/utils/text_styles.dart';

class OfficerActionPopUpMenu extends StatelessWidget {
  final bool onlyIcon;
  final Complain complain;
  final ActionTypePref typePref;
  final ActionViewPref viewPref;

  const OfficerActionPopUpMenu({required this.onlyIcon, required this.complain, required this.typePref, required this.viewPref});

  @override
  Widget build(BuildContext context) {
    var icon = const Icon(Icons.more_vert, color: grey80);
    var label = Text('Complain Actions'.translate, style: sl<TextStyles>().text15_600(white));
    var actionMenus = typePref == ActionTypePref.appeal ? _appealActionMenus : _complainActionMenus;
    if (!actionMenus.haveList) return const SizedBox.shrink();
    return PopupMenuButton(
      iconSize: 24,
      initialValue: '',
      clipBehavior: Clip.antiAlias,
      child: onlyIcon ? icon : label,
      onSelected: (menu) => _onSelect(menu),
      // child: onlyIcon ? icon : Row(mainAxisSize: MainAxisSize.min, children: [label, width, icon]),
      itemBuilder: (context) => actionMenus.map((item) => _popupMenuItem(context, item)).toList(),
    );
  }

  PopupMenuItem<dynamic> _popupMenuItem(BuildContext context, ActionMenu action) {
    // var icon = SvgImage(image: action.icon, color: grey80, width: 18, height: 18);
    var label = Text(action.label, style: sl<TextStyles>().text14_600(grey80));
    return PopupMenuItem(value: action.value, child: label);
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

  void _onSelect(String menu) {
    if (menu == 'send_opinion') {
      sl<Routes>().sendForOpinionScreen(complain, typePref, viewPref).push();
    } else if (menu == 'give_opinion') {
      sl<Routes>().giveOpinionScreen(complain, typePref, viewPref).push();
    } else if (menu == 'another_office') {
      sl<Routes>().toAnotherOfficeScreen(complain, typePref, viewPref).push();
    } else if (menu == 'subordinate_office') {
      sl<Routes>().subordinateOfficeScreen(complain, typePref, viewPref).push();
    } else if (menu == 'subordinate_office_gro') {
      sl<Routes>().subordinateOfficeGroScreen(complain, typePref, viewPref).push();
    } else if (menu == 'to_appeal_officer') {
      sl<Routes>().sendToAppealOfficerScreen(complain, typePref, viewPref).push();
    } else if (menu == 'guidelines_to_providing_services') {
      sl<Routes>().provideServiceScreen(complain, typePref, viewPref).push();
    } else if (menu == 'send_for_permission') {
      sl<Routes>().sendPermissionScreen(complain, typePref, viewPref).push();
    } else if (menu == 'give_permission'){
      sl<Routes>().givePermissionScreen(complain, typePref, viewPref).push();
    } else if (menu == 'request_document') {
      sl<Routes>().requestDocumentScreen(complain, typePref, viewPref).push();
    } else if (menu == 'start_investigation') {
      sl<Routes>().startInvestigationScreen(complain, typePref, viewPref).push();
    } else if (menu == 'submit_investigation') {
      sl<Routes>().investigationReportScreen(complain, typePref, viewPref).push();
    } else if (menu == 'hearing_notice') {
      sl<Routes>().hearingNoticeScreen(complain, typePref, viewPref).push();
    } else if (menu == 'take_hearing') {
      sl<Routes>().takeHearingScreen(complain, typePref, viewPref).push();
    } else if (menu == 'provide_more_evidence') {
      sl<Routes>().moreEvidenceScreen(complain, typePref, viewPref).push();
    } else if (menu == 'approve_disapprove') {
      sl<Routes>().approveDisapproveScreen(complain, typePref, viewPref).push();
    } else if (menu == 'reject') {
      sl<Routes>().rejectScreen(complain, typePref, viewPref).push();
    } else if (menu == 'close') {
      sl<Routes>().closeComplainScreen(complain, typePref, viewPref).push();
    } else {
      sl<Routes>().closeComplainScreen(complain, typePref, viewPref).push();
    }
  }
}
