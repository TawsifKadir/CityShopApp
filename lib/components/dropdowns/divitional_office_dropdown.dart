import 'package:flutter/material.dart';

import 'package:grs/components/ui_widgets/dropdown_label.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/list_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/models/doptor_apis/divitional_office.dart';
import 'package:grs/utils/size_config.dart';
import 'package:grs/utils/text_styles.dart';

class DivitionalOfficeDropdown extends StatelessWidget {
  final DivitionalOffice? divitionalOffice;
  final List<DivitionalOffice> divitionalOfficeList;
  final Function(DivitionalOffice?)? onChanged;

  const DivitionalOfficeDropdown({required this.divitionalOffice, required this.divitionalOfficeList, required this.onChanged});

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
          value: divitionalOffice,
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
    if (divitionalOffice == null || !divitionalOfficeList.haveList) return 'Select divitional office'.translate;
    var index = divitionalOfficeList.indexWhere((item) => item.id == divitionalOffice!.id);
    return index < 0 ? 'Select divitional office'.translate : divitionalOfficeList[index].office_name;
  }

  List<DropdownMenuItem<DivitionalOffice>> get _dropdownMenuItems {
    List<DropdownMenuItem<DivitionalOffice>> menuItems = [];
    if (!divitionalOfficeList.haveList) return menuItems;
    divitionalOfficeList.forEach((item) => menuItems.add(_menuItem(item)));
    return menuItems;
  }

  DropdownMenuItem<DivitionalOffice> _menuItem(DivitionalOffice item) {
    var empty_space = '    ';
    var overflow = TextOverflow.ellipsis;
    var style = sl<TextStyles>().text14_400(black);
    var label = Text('$empty_space${item.office_name}', maxLines: 1, overflow: overflow, style: style);
    return DropdownMenuItem<DivitionalOffice>(value: item, child: label);
  }
}
