import 'package:flutter/material.dart';

import 'package:grs/components/ui_widgets/dropdown_label.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/list_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/models/dummy/data_type.dart';
import 'package:grs/utils/size_config.dart';
import 'package:grs/utils/text_styles.dart';

class LanguageDropdown extends StatelessWidget {
  final DataType? language;
  final Function(DataType?)? onChanged;
  const LanguageDropdown({required this.language, required this.onChanged});

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
          value: language,
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
    if (language == null || !language_types.haveList) return 'Select language type'.translate;
    var index = language_types.indexWhere((item) => item.value == language!.value);
    return index < 0 ? 'Select language type'.translate : language_types[index].label;
  }

  List<DropdownMenuItem<DataType>> get _dropdownMenuItems {
    List<DropdownMenuItem<DataType>> menuItems = [];
    if (!language_types.haveList) return menuItems;
    language_types.forEach((item) => menuItems.add(_menuItem(item)));
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
