import 'package:flutter/material.dart';

import 'package:grs/components/ui_widgets/dropdown_label.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/list_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/models/safety_net/safety_net.dart';
import 'package:grs/utils/size_config.dart';
import 'package:grs/utils/text_styles.dart';

class SafetyNetDropdown extends StatelessWidget {
  final SafetyNet? safetyNet;
  final List<SafetyNet> safetyNets;
  final Function(SafetyNet?)? onChanged;

  const SafetyNetDropdown({required this.safetyNet, required this.safetyNets, required this.onChanged});

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
          value: safetyNet,
          onChanged: onChanged,
          items: _dropdownMenuItems,
          hint: DropdownLabel(_dropdownHint),
          icon: Padding(padding: const EdgeInsets.only(right: 4), child: dropdownIcon),
        ),
      ),
    );
  }

  String get _dropdownHint {
    if (safetyNet == null || !safetyNets.haveList) return 'Select safety net programme'.translate;
    var index = safetyNets.indexWhere((item) => item.id == safetyNet!.id);
    return index < 0 ? 'Select safety net programme'.translate : safetyNets[index].label;
  }

  List<DropdownMenuItem<SafetyNet>> get _dropdownMenuItems {
    List<DropdownMenuItem<SafetyNet>> menuItems = [];
    if (!safetyNets.haveList) return menuItems;
    safetyNets.forEach((item) => menuItems.add(_menuItem(item)));
    return menuItems;
  }

  DropdownMenuItem<SafetyNet> _menuItem(SafetyNet item) {
    var empty_space = '    ';
    var overflow = TextOverflow.ellipsis;
    var style = sl<TextStyles>().text14_400(black);
    var label = Text('$empty_space${item.label}', maxLines: 1, overflow: overflow, style: style);
    return DropdownMenuItem<SafetyNet>(value: item, child: label);
  }
}
