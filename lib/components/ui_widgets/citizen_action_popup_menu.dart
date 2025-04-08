import 'package:flutter/material.dart';

import 'package:grs/bottom_sheets/rating_bottom_sheet.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/route_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/models/complain/complain.dart';
import 'package:grs/models/dummy/action_menu.dart';
import 'package:grs/service/routes.dart';
import 'package:grs/utils/text_styles.dart';

class CitizenActionPopUpMenu extends StatelessWidget {
  final bool onlyIcon;
  final Complain complain;
  const CitizenActionPopUpMenu({required this.onlyIcon, required this.complain});

  @override
  Widget build(BuildContext context) {
    var icon = const Icon(Icons.more_vert, color: grey80);
    var label = Text('Complain Actions'.translate, style: sl<TextStyles>().text15_600(white));
    return PopupMenuButton(
      iconSize: 24,
      initialValue: '',
      clipBehavior: Clip.antiAlias,
      child: onlyIcon ? icon : label,
      onSelected: (menu) => _onSelect(menu),
      itemBuilder: (context) => _actionMenus.map((item) => _popupMenuItem(context, item)).toList(),
    );
  }

  PopupMenuItem<dynamic> _popupMenuItem(BuildContext context, ActionMenu action) {
    var label = Text(action.label, style: sl<TextStyles>().text14_600(grey80));
    return PopupMenuItem(value: action.value, child: label);
  }

  List<ActionMenu> get _actionMenus {
    var status = complain.currentStatus ?? '';
    var ratingGiven = complain.isRatingGiven;
    var appealGiven = complain.isAppealRatingGiven;
    var evidenceProvide = complain.isEvidenceProvide;
    var hearingDate = complain.isSeeHearingDate;
    var officerStatus = status == 'CLOSED_OTHERS' || status == 'CLOSED_ACCUSATION_INCORRECT' || status == 'CLOSED_ACCUSATION_PROVED';
    var appealStatus =
        status == 'APPEAL_CLOSED_OTHERS' || status == 'APPEAL_CLOSED_ACCUSATION_INCORRECT' || status == 'APPEAL_CLOSED_ACCUSATION_PROVED';
    // var isRating = (officerStatus || appealStatus) && (ratingGiven == null || ratingGiven == 0);
    var isRating = false;
    var isAppeal = (status == 'CLOSED_ACCUSATION_INCORRECT' || status == 'CLOSED' || status == 'REJECTED') && (appealGiven == null || appealGiven == 0);
    var isFile = (status == 'INV_NOTICE_FILE' || status == 'INV_NOTICE_FILE_APPEAL') && (evidenceProvide == null || evidenceProvide == 0);
    var isHearing = (status == 'INV_NOTICE_HEARING' || status == 'INV_NOTICE_HEARING_APPEAL') && (hearingDate == null || hearingDate == 0);
    var menusByStatus = [if (isFile) evidence_material, if (isHearing) hearing_date, if (isRating) rating, if (isAppeal) appeal];
    return menusByStatus;
  }

  void _onSelect(String menu) {
    if (menu == 'hearing_date') {
      sl<Routes>().hearingDateScreen(complain).push();
    } else if (menu == 'evidence_material') {
      sl<Routes>().evidenceMaterialScreen(complain).push();
    } else if (menu == 'ratings') {
      ratingBottomSheet(complain);
    } else if (menu == 'appeal') {
      sl<Routes>().sendAppealScreen(complain).push();
      // appealBottomSheet(complain);
    } else {
      // User have to do nothing
    }
  }
}
