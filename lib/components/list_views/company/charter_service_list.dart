import 'package:flutter/material.dart';

import 'package:grs/bottom_sheets/charter_service_details_sheet.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/libraries/formatters.dart';
import 'package:grs/models/citizen_charter/charter_service.dart';
import 'package:grs/utils/text_styles.dart';

class CharterServiceList extends StatelessWidget {
  final List<CharterService> services;
  const CharterServiceList({required this.services});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: _serviceCard,
      clipBehavior: Clip.antiAlias,
      itemCount: services.length,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24),
    );
  }

  Widget _serviceCard(BuildContext context, int index) {
    var service = services[index];
    var slNo = sl<Formatters>().localizeNumber(index + 1 > 9 ? '${index + 1}' : '0${index + 1}');
    return InkWell(
      onTap: () => charterServiceDetailsBottomSheet(service),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: index == 0 ? 4 : 0),
        margin: EdgeInsets.only(bottom: index == services.length - 1 ? 24 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$slNo. ${service.service_name.trim()}', style: sl<TextStyles>().text15_600(black)),
            if (service.service_procedure.hasString) const SizedBox(height: 4),
            if (service.service_procedure.hasString) Text(service.service_procedure.trim(), style: sl<TextStyles>().text15_400(black)),
            if (index != services.length - 1) const SizedBox(height: 16),
            if (index != services.length - 1) Container(width: double.infinity, height: 1, color: grey60),
          ],
        ),
      ),
    );
  }
}
