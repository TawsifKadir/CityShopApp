import 'package:flutter/material.dart';

import 'package:grs/components/ui_widgets/dropdown_label.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/list_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/models/dummy/data_type.dart';
import 'package:grs/utils/size_config.dart';
import 'package:grs/utils/text_styles.dart';

class SuggestionDropdown extends StatelessWidget {
  final DataType? suggestion;
  final Function(DataType?)? onChanged;

  const SuggestionDropdown({required this.suggestion, required this.onChanged});

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
          value: suggestion,
          onChanged: onChanged,
          items: _dropdownMenuItems,
          hint: DropdownLabel(_dropdownHint),
          icon: Padding(padding: const EdgeInsets.only(right: 4), child: dropdownIcon),
        ),
      ),
    );
  }

  String get _dropdownHint {
    if (suggestion == null || !suggestion_subjects.haveList) return 'Select the subject of suggestion'.translate;
    var index = suggestion_subjects.indexWhere((item) => item.value == suggestion!.value);
    return index < 0 ? 'Select the subject of suggestion'.translate : suggestion_subjects[index].label;
  }

  List<DropdownMenuItem<DataType>> get _dropdownMenuItems {
    List<DropdownMenuItem<DataType>> menuItems = [];
    if (!suggestion_subjects.haveList) return menuItems;
    suggestion_subjects.forEach((item) => menuItems.add(_menuItem(item)));
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
