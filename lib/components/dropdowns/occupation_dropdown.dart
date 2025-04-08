import 'package:flutter/material.dart';

import 'package:grs/components/ui_widgets/dropdown_label.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/list_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/models/occupation/occupation.dart';
import 'package:grs/utils/size_config.dart';
import 'package:grs/utils/text_styles.dart';

class OccupationDropdown extends StatelessWidget {
  final Occupation? occupation;
  final List<Occupation> occupationList;
  final Function(Occupation?)? onChanged;

  const OccupationDropdown({required this.occupation, required this.occupationList, required this.onChanged});

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
          value: occupation,
          onChanged: onChanged,
          items: _dropdownMenuItems,
          hint: DropdownLabel(_dropdownHint),
          icon: Padding(padding: const EdgeInsets.only(right: 4), child: dropdownIcon),
        ),
      ),
    );
  }

  String get _dropdownHint {
    if (occupation == null || !occupationList.haveList) return 'Select your occupation'.translate;
    var index = occupationList.indexWhere((item) => item.id == occupation!.id);
    return index < 0 ? 'Select your occupation'.translate : occupationList[index].occupation;
  }

  List<DropdownMenuItem<Occupation>> get _dropdownMenuItems {
    List<DropdownMenuItem<Occupation>> menuItems = [];
    if (!occupationList.haveList) return menuItems;
    occupationList.forEach((item) => menuItems.add(_menuItem(item)));
    return menuItems;
  }

  DropdownMenuItem<Occupation> _menuItem(Occupation item) {
    var empty_space = '    ';
    var overflow = TextOverflow.ellipsis;
    var style = sl<TextStyles>().text14_400(black);
    var label = Text('$empty_space${item.occupation}', maxLines: 1, overflow: overflow, style: style);
    return DropdownMenuItem<Occupation>(value: item, child: label);
  }
}
