import 'package:flutter/material.dart';

import 'package:grs/components/ui_widgets/dropdown_label.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/list_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/models/qualification/qualification.dart';
import 'package:grs/utils/size_config.dart';
import 'package:grs/utils/text_styles.dart';

class QualificationDropdown extends StatelessWidget {
  final Qualification? qualification;
  final List<Qualification> qualificationList;
  final Function(Qualification?)? onChanged;

  const QualificationDropdown({required this.qualification, required this.qualificationList, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    var border = Border.all(color: grey60);
    var radius = BorderRadius.circular(6);
    var dropdownIcon = const Icon(Icons.keyboard_arrow_down, size: 24, color: grey80);
    return Container(
      height: 48,
      width: SizeConfig.width,
      decoration: BoxDecoration(border: border, borderRadius: radius),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isDense: true,
          isExpanded: true,
          value: qualification,
          onChanged: onChanged,
          items: _dropdownMenuItems,
          hint: DropdownLabel(_dropdownHint),
          icon: Padding(padding: const EdgeInsets.only(right: 4), child: dropdownIcon),
        ),
      ),
    );
  }

  String get _dropdownHint {
    if (qualification == null || !qualificationList.haveList) return 'Select your qualification'.translate;
    var index = qualificationList.indexWhere((item) => item.id == qualification!.id);
    return index < 0 ? 'Select your qualification'.translate : qualificationList[index].qualification;
  }

  List<DropdownMenuItem<Qualification>> get _dropdownMenuItems {
    List<DropdownMenuItem<Qualification>> menuItems = [];
    if (!qualificationList.haveList) return menuItems;
    qualificationList.forEach((item) => menuItems.add(_menuItem(item)));
    return menuItems;
  }

  DropdownMenuItem<Qualification> _menuItem(Qualification item) {
    var empty_space = '    ';
    var overflow = TextOverflow.ellipsis;
    var style = sl<TextStyles>().text14_400(black);
    var label = Text('$empty_space${item.qualification}', maxLines: 1, overflow: overflow, style: style);
    return DropdownMenuItem<Qualification>(value: item, child: label);
  }
}
