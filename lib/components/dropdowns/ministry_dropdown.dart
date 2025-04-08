import 'package:flutter/material.dart';

import 'package:grs/components/ui_widgets/dropdown_label.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/list_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/models/doptor_apis/ministry.dart';
import 'package:grs/utils/size_config.dart';
import 'package:grs/utils/text_styles.dart';

class MinistryDropdown extends StatelessWidget {
  final Ministry? ministry;
  final List<Ministry> ministryList;
  final Function(Ministry?)? onChanged;

  const MinistryDropdown({required this.ministry, required this.ministryList, required this.onChanged});

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
          value: ministry,
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
    if (ministry == null || !ministryList.haveList) return 'Select ministry'.translate;
    var index = ministryList.indexWhere((item) => item == ministry);
    return index < 0 ? 'Select ministry'.translate : ministryList[index].ministry_name;
  }

  List<DropdownMenuItem<Ministry>> get _dropdownMenuItems {
    List<DropdownMenuItem<Ministry>> menuItems = [];
    if (!ministryList.haveList) return menuItems;
    ministryList.forEach((item) => menuItems.add(_menuItem(item)));
    return menuItems;
  }

  DropdownMenuItem<Ministry> _menuItem(Ministry item) {
    var empty_space = '    ';
    var overflow = TextOverflow.ellipsis;
    var style = sl<TextStyles>().text14_400(black);
    var label = Text('$empty_space${item.ministry_name}', maxLines: 1, overflow: overflow, style: style);
    return DropdownMenuItem<Ministry>(value: item, child: label);
  }
}
