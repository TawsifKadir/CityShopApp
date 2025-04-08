import 'package:flutter/material.dart';
import 'package:grs/components/ui_widgets/officer_action_popup_menu.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/constants/date_formats.dart';
import 'package:grs/di.dart';
import 'package:grs/enum/enums.dart';
import 'package:grs/extensions/route_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/libraries/formatters.dart';
import 'package:grs/libraries/text_to_speak.dart';
import 'package:grs/library_widgets/svg_image.dart';
import 'package:grs/models/complain/complain.dart';
import 'package:grs/service/routes.dart';
import 'package:grs/utils/assets.dart';
import 'package:grs/utils/text_styles.dart';

class ComplainList extends StatelessWidget {
  final String? menu;
  final ComplainListPref pref;
  final List<Complain> complainList;
  final ScrollController? scrollController;

  const ComplainList({required this.pref, required this.complainList, this.scrollController, this.menu});

  @override
  Widget build(BuildContext context) {
    var isAppeal = pref == ComplainListPref.appeal_regular;
    var isRegular = pref == ComplainListPref.complain_regular || pref == ComplainListPref.my_regular_complain;
    return ListView.builder(
      shrinkWrap: true,
      controller: scrollController,
      clipBehavior: Clip.antiAlias,
      itemCount: complainList.length,
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemBuilder: isRegular || isAppeal ? _regularComplainCardCard : _normalComplainCardCard,
    );
  }

  Widget _normalComplainCardCard(BuildContext context, int index) {
    var complain = complainList[index];
    var date = sl<Formatters>().formatDate(DATE_FORMAT_4, '${complain.submissionDate}');
    return Container(
      width: double.infinity,
      padding: EdgeInsets.zero,
      margin: EdgeInsets.only(bottom: index == complainList.length - 1 ? 24 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(complain.tracking_number, style: sl<TextStyles>().text16_600(primary)),
          Text(date, style: sl<TextStyles>().text16_400(black)),
          Text(complain.subject ?? '', maxLines: 2, overflow: TextOverflow.ellipsis, style: sl<TextStyles>().text16_400(black)),
          if (index != complainList.length - 1) const SizedBox(height: 16),
          if (index != complainList.length - 1) Container(width: double.infinity, height: 1, color: grey60),
        ],
      ),
    );
  }

  Widget _regularComplainCardCard(BuildContext context, int index) {
    var iconPadding = const EdgeInsets.only(top: 2);
    // onTap: sl<Routes>().complainDetailsScreen(complainList[index]).push,
    var calender = Padding(padding: iconPadding, child: SvgImage(image: Assets.calendar_outline, height: 24, color: primary));
    var grievanceInfo = Expanded(child: _GrievanceInfo(context, index));
    return InkWell(
      onTap: () => _textToSpeech(complainList[index]),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.zero,
        margin: EdgeInsets.only(bottom: index == complainList.length - 1 ? 24 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [calender, const SizedBox(width: 6), grievanceInfo]),
            if (index != complainList.length - 1) const SizedBox(height: 16),
            if (index != complainList.length - 1) Container(width: double.infinity, height: 1, color: grey60),
          ],
        ),
      ),
    );
  }

  Widget _GrievanceInfo(BuildContext context, int index) {
    var complain = complainList[index];
    var viewPref = ActionViewPref.list_item;
    var typePref = pref == ComplainListPref.appeal_regular ? ActionTypePref.appeal : ActionTypePref.complain;
    var isIncoming = menu != null && menu == 'arrival';
    var isRegular = (pref == ComplainListPref.complain_regular) || (pref == ComplainListPref.appeal_regular);
    var date = sl<Formatters>().formatDate(DATE_FORMAT_4, '${complain.submissionDate}');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Text(date, style: sl<TextStyles>().text16_600(primary))),
            const SizedBox(width: 20),
            if (isRegular && isIncoming) OfficerActionPopUpMenu(onlyIcon: true, complain: complain, viewPref: viewPref, typePref: typePref),
          ],
        ),
        const SizedBox(height: 1),
        // Text('${complain.id ?? ''}', maxLines: 2, overflow: TextOverflow.ellipsis, style: sl<TextStyles>().text14_600(black)),
        _statusComponent(context: context, status: complain.format_status),
        const SizedBox(height: 2),
        Text(
          '${'Tracking No'.translate}: ${complain.trackingNumber ?? ''}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: sl<TextStyles>().text14_600(black),
        ),
        const SizedBox(height: 1),
        Text(complain.subject ?? '', maxLines: 2, overflow: TextOverflow.ellipsis, style: sl<TextStyles>().text16_600(black)),
        const SizedBox(height: 1),
        Text(complain.details ?? '', maxLines: 2, overflow: TextOverflow.ellipsis, style: sl<TextStyles>().text15_400(black)),
        const SizedBox(height: 1),
        _viewDetailsButton(context, index),
      ],
    );
  }

  Widget _statusComponent({required BuildContext context, required String status}) {
    var border = Border.all(color: primary);
    var radius = BorderRadius.circular(04);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 1.5, horizontal: 4),
      decoration: BoxDecoration(color: primary, border: border, borderRadius: radius),
      child: Text(status, maxLines: 1, overflow: TextOverflow.ellipsis, style: sl<TextStyles>().text14_600(white)),
    );
  }

  Widget _viewDetailsButton(BuildContext context, int index) {
    var label = Text('View details'.translate, style: sl<TextStyles>().text16_500(primary));
    var arrow = SvgImage(image: Assets.arrow_right, color: primary, height: 20);
    return InkWell(
      onTap: pref == ComplainListPref.appeal_regular
          ? sl<Routes>().appealComplainDetailsScreen(menu ?? '', pref, complainList[index]).push
          : sl<Routes>().officerComplainDetailsScreen(menu ?? '', pref, complainList[index]).push,
      child: Row(children: [label, const SizedBox(width: 4), arrow]),
    );
  }

  void _textToSpeech(Complain complain) {
    var trackingNo = '${'tracking number is'.translate}: ${complain.tracking_number}';
    var subject = '${'subject is'.translate}: ${complain.subject ?? 'not found'.translate}';
    var text = '${'Your complain'.translate} $trackingNo ${'and'.translate} $subject';
    sl<TextToSpeak>().startSpeaking(text);
  }
}
