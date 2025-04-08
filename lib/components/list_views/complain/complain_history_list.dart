import 'package:flutter/material.dart';

import 'package:grs/constants/colors.dart';
import 'package:grs/constants/date_formats.dart';
import 'package:grs/core_widgets/profile_image.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/libraries/formatters.dart';
import 'package:grs/models/history/complain_history.dart';
import 'package:grs/utils/text_styles.dart';

class ComplainHistoryList extends StatelessWidget {
  final List<ComplainHistory> histories;
  const ComplainHistoryList({required this.histories});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: _historyCard,
      clipBehavior: Clip.antiAlias,
      itemCount: histories.length,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24),
    );
  }

  Widget _historyCard(BuildContext context, int index) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 16),
      margin: EdgeInsets.only(bottom: index == histories.length - 1 ? 20 : 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ProfileImage(image: null, box_size: 75, image_size: 75),
          const SizedBox(width: 16),
          Expanded(child: _historyInformation(context, index)),
        ],
      ),
    );
  }

  Widget _historyInformation(BuildContext context, int index) {
    var history = histories[index];
    var step = sl<Formatters>().localizeNumber('${histories.length - index}');
    var date = sl<Formatters>().formatDate(DATE_FORMAT_11, history.createdAt);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Text('${'Step'.translate}: $step', style: sl<TextStyles>().text15_600(primary))),
            Text(date, style: sl<TextStyles>().text15_400(black)),
          ],
        ),
        Text(history.format_action_status, style: sl<TextStyles>().text15_600(black)),
        if (history.note != null) Text(history.note!.removeHtml.trim(), style: sl<TextStyles>().text15_400(black)),
      ],
    );
  }
}
