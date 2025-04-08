import 'package:flutter/material.dart';

import 'package:grs/constants/colors.dart';
import 'package:grs/di.dart';
import 'package:grs/libraries/formatters.dart';
import 'package:grs/models/dashboard/service_grievence.dart';
import 'package:grs/utils/text_styles.dart';

class ServiceGrievanceList extends StatelessWidget {
  final List<ServiceGrievance> serviceList;
  const ServiceGrievanceList({required this.serviceList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: _service_complain_count_ard,
      clipBehavior: Clip.antiAlias,
      itemCount: serviceList.length,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
    );
  }

  Widget _service_complain_count_ard(BuildContext context, int index) {
    var serviceInfo = serviceList[index];
    return Container(
      width: double.infinity,
      color: index.isEven ? grey.withOpacity(0.05) : white,
      padding: const EdgeInsets.symmetric(vertical: 08, horizontal: 16),
      child: Row(
        children: [
          SizedBox(width: 32, child: Text(sl<Formatters>().localizeNumber('${index + 1}'), style: sl<TextStyles>().text16_600(black))),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              serviceInfo.service?.service_name ?? '',
              maxLines: 3,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              style: sl<TextStyles>().text16_500(black),
            ),
          ),
          const SizedBox(width: 10),
          Text(sl<Formatters>().localizeNumber('${serviceInfo.count ?? 0}'), style: sl<TextStyles>().text16_600(black)),
        ],
      ),
    );
  }
}
