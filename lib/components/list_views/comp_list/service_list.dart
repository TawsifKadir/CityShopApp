import 'package:flutter/material.dart';

import 'package:grs/constants/colors.dart';
import 'package:grs/di.dart';
import 'package:grs/models/service/service.dart';
import 'package:grs/utils/text_styles.dart';

class ServiceList extends StatelessWidget {
  final Service? selectedService;
  final List<Service> serviceList;
  final Function(int) onTap;
  const ServiceList({required this.selectedService, required this.serviceList, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemBuilder: _serviceCard,
      clipBehavior: Clip.antiAlias,
      itemCount: serviceList.length,
      physics: const BouncingScrollPhysics(),
    );
  }

  Widget _serviceCard(BuildContext context, int index) {
    var service = serviceList[index];
    var name = service.service_name;
    var selected = selectedService != null && selectedService!.id == service.id;
    var radioOff = const Icon(Icons.radio_button_off, color: primary, size: 20);
    var radioOn = const Icon(Icons.radio_button_checked, color: primary, size: 20);
    var label = Text(name, maxLines: 1, overflow: TextOverflow.ellipsis, style: sl<TextStyles>().text14_400(grey80));
    return InkWell(
      onTap: () => onTap(index),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: index == serviceList.length - 1 ? 24 : 16),
        child: Row(children: [selected ? radioOn : radioOff, const SizedBox(width: 06), Expanded(child: label)]),
      ),
    );
  }
}
