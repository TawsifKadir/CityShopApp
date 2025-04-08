import 'package:flutter/material.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/constants/date_formats.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/route_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/libraries/formatters.dart';
import 'package:grs/libraries/text_to_speak.dart';
import 'package:grs/library_widgets/svg_image.dart';
import 'package:grs/models/complain/complain.dart';
import 'package:grs/service/routes.dart';
import 'package:grs/utils/assets.dart';
import 'package:grs/utils/text_styles.dart';

class CitizenComplainList extends StatelessWidget {
  final List<Complain> complainList;
  const CitizenComplainList({required this.complainList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      clipBehavior: Clip.antiAlias,
      itemCount: complainList.length,
      itemBuilder: _complainItemCard,
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      padding: const EdgeInsets.symmetric(horizontal: 24),
    );
  }

  Widget _complainItemCard(BuildContext context, int index) {
    var icon = SvgImage(image: Assets.shield_outline, height: 30, color: primary);
    return InkWell(
      onTap: () => _textToSpeech(complainList[index]),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: index == 0 ? 16 : 0),
        margin: EdgeInsets.only(bottom: index == complainList.length - 1 ? 24 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [icon, const SizedBox(width: 10), Expanded(child: _grievanceInfo(context, index))],
            ),
            if (index != complainList.length - 1) const SizedBox(height: 16),
            if (index != complainList.length - 1) Container(width: double.infinity, height: 1, color: grey60),
          ],
        ),
      ),
    );
  }

  Widget _grievanceInfo(BuildContext context, int index) {
    var complain = complainList[index];
    var date = sl<Formatters>().formatDate(DATE_FORMAT_4, '${complain.submissionDate}');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('#${complain.tracking_number}', style: sl<TextStyles>().text18_600(primary)),
        const SizedBox(height: 1),
        _statusComponent(context: context, status: complain.format_status),
        const SizedBox(height: 1),
        Text(complain.subject ?? '', maxLines: 2, overflow: TextOverflow.ellipsis, style: sl<TextStyles>().text16_600(black)),
        const SizedBox(height: 1),
        Text('${'Complain date'.translate}: $date', style: sl<TextStyles>().text15_400(black)),
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
      onTap: sl<Routes>().citizenComplainDetailsScreen(complainList[index]).push,
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
