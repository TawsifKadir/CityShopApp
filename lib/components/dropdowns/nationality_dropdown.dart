import 'package:flutter/material.dart';

import 'package:grs/components/ui_widgets/dropdown_label.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/list_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/models/country/country.dart';
import 'package:grs/utils/size_config.dart';
import 'package:grs/utils/text_styles.dart';

class NationalityDropdown extends StatelessWidget {
  final Country? nationality;
  final List<Country> nationalityList;
  final Function(Country?)? onChanged;

  const NationalityDropdown({required this.nationality, required this.nationalityList, required this.onChanged});

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
          value: nationality,
          onChanged: onChanged,
          items: _dropdownMenuItems,
          hint: DropdownLabel(_dropdownHint),
          icon: Padding(padding: const EdgeInsets.only(right: 4), child: dropdownIcon),
        ),
      ),
    );
  }

  String get _dropdownHint {
    if (nationality == null || !nationalityList.haveList) return 'Select your nationality'.translate;
    var index = nationalityList.indexWhere((item) => item.id == nationality!.id);
    return index < 0 ? 'Select your nationality'.translate : nationalityList[index].nationality;
  }

  List<DropdownMenuItem<Country>> get _dropdownMenuItems {
    List<DropdownMenuItem<Country>> menuItems = [];
    if (!nationalityList.haveList) return menuItems;
    nationalityList.forEach((item) => menuItems.add(_menuItem(item)));
    return menuItems;
  }

  DropdownMenuItem<Country> _menuItem(Country item) {
    var empty_space = '    ';
    var overflow = TextOverflow.ellipsis;
    var style = sl<TextStyles>().text14_400(black);
    var label = Text('$empty_space${item.nationality}', maxLines: 1, overflow: overflow, style: style);
    return DropdownMenuItem<Country>(value: item, child: label);
  }
}
