import 'package:flutter/material.dart';

import 'package:grs/constants/colors.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/libraries/formatters.dart';
import 'package:grs/models/dummy/resource.dart';
import 'package:grs/utils/text_styles.dart';

class FrequentQuestionList extends StatelessWidget {
  final List<Resource> frequentQuestionList;
  const FrequentQuestionList({required this.frequentQuestionList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: _question_answer_card,
      clipBehavior: Clip.antiAlias,
      itemCount: frequentQuestionList.length,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24),
    );
  }

  Widget _question_answer_card(BuildContext context, int index) {
    var resource = frequentQuestionList[index];
    var slNo = sl<Formatters>().localizeNumber('${index + 1}');
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: index == 0 ? 16 : 0),
      margin: EdgeInsets.only(bottom: index == frequentQuestionList.length - 1 ? 24 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$slNo. ${resource.question.translate}', style: sl<TextStyles>().text16_600(black)),
          const SizedBox(height: 4),
          Text(resource.answer.translate, style: sl<TextStyles>().text15_400(black)),
          if (index != frequentQuestionList.length - 1) const SizedBox(height: 16),
          if (index != frequentQuestionList.length - 1) Container(width: double.infinity, height: 1, color: grey60),
        ],
      ),
    );
  }
}
