import 'package:flutter/material.dart';

import 'package:grs/components/ui_widgets/dropdown_label.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/list_ext.dart';
import 'package:grs/models/dummy/data_type.dart';
import 'package:grs/utils/size_config.dart';
import 'package:grs/utils/text_styles.dart';

class WitnessDropdown extends StatelessWidget {
  final DataType? witness;
  final List<DataType> witnessList;
  final Function(DataType?)? onChanged;

  const WitnessDropdown({required this.witness, required this.witnessList, required this.onChanged});

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
          value: witness,
          isExpanded: true,
          onChanged: onChanged,
          items: _dropdownMenuItems,
          hint: DropdownLabel(_witnessName),
          icon: Padding(padding: const EdgeInsets.only(right: 4), child: dropdownIcon),
        ),
      ),
    );
  }

  String get _witnessName {
    if (witness == null || !witnessList.haveList) return 'Select a witness';
    var item = witnessList.firstWhere((item) => item == witness);
    return item.label;
  }

  List<DropdownMenuItem<DataType>> get _dropdownMenuItems {
    List<DropdownMenuItem<DataType>> menuItems = [];
    if (!witnessList.haveList) return menuItems;
    witnessList.forEach((item) => menuItems.add(_menuItem(item)));
    return menuItems;
  }

  DropdownMenuItem<DataType> _menuItem(DataType item) {
    var empty_space = '    ';
    var overflow = TextOverflow.ellipsis;
    var style = sl<TextStyles>().text14_400(black);
    var label = Text('$empty_space${item.label}', maxLines: 1, overflow: overflow, style: style);
    return DropdownMenuItem<DataType>(value: item, child: label);
  }
}
