import 'package:flutter/material.dart';

import 'package:grs/components/ui_widgets/dropdown_label.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/list_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/models/service/service.dart';
import 'package:grs/utils/size_config.dart';
import 'package:grs/utils/text_styles.dart';

class ServiceDropdown extends StatelessWidget {
  final Service? service;
  final List<Service> serviceList;
  final Function(Service?)? onChanged;

  const ServiceDropdown({required this.service, required this.serviceList, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    var border = Border.all(color: grey60);
    var radius = BorderRadius.circular(6);
    var dropdownIcon = const Icon(Icons.keyboard_arrow_down, size: 24, color: grey80);
    return Container(
      height: 48,
      width: SizeConfig.width,
      decoration: BoxDecoration(color: white, border: border, borderRadius: radius),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isDense: true,
          value: service,
          isExpanded: true,
          onChanged: onChanged,
          items: _dropdownMenuItems,
          hint: DropdownLabel(_ministryName),
          icon: Padding(padding: const EdgeInsets.only(right: 4), child: dropdownIcon),
        ),
      ),
    );
  }

  String get _ministryName {
    if (service == null || !serviceList.haveList) return 'Select any service'.translate;
    var index = serviceList.indexWhere((item) => item.id == service!.id);
    return index < 0 ? 'Select any service'.translate : serviceList[index].service_name;
  }

  List<DropdownMenuItem<Service>> get _dropdownMenuItems {
    List<DropdownMenuItem<Service>> menuItems = [];
    if (!serviceList.haveList) return menuItems;
    serviceList.forEach((item) => menuItems.add(_menuItem(item)));
    return menuItems;
  }

  DropdownMenuItem<Service> _menuItem(Service item) {
    var empty_space = '    ';
    var overflow = TextOverflow.ellipsis;
    var style = sl<TextStyles>().text14_400(black);
    var label = Text('$empty_space${item.service_name}', maxLines: 1, overflow: overflow, style: style);
    return DropdownMenuItem<Service>(value: item, child: label);
  }
}
