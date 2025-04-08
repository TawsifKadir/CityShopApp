import 'package:flutter/material.dart';

import 'package:grs/components/ui_widgets/dropdown_label.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/list_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/models/district/district.dart';
import 'package:grs/utils/size_config.dart';
import 'package:grs/utils/text_styles.dart';

class DistrictDropdown extends StatelessWidget {
  final String type;
  final District? city;
  final List<District> cities;
  final Function(District?)? onChanged;

  const DistrictDropdown({required this.type, required this.city, required this.cities, required this.onChanged});

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
          value: city,
          onChanged: onChanged,
          items: _dropdownMenuItems,
          hint: DropdownLabel(_dropdownHint),
          icon: Padding(padding: const EdgeInsets.only(right: 4), child: dropdownIcon),
        ),
      ),
    );
  }

  String get _dropdownHint {
    if (city == null || !cities.haveList) return _getHint;
    var index = cities.indexWhere((item) => item.id == city!.id);
    return index < 0 ? _getHint : cities[index].label;
  }

  List<DropdownMenuItem<District>> get _dropdownMenuItems {
    List<DropdownMenuItem<District>> menuItems = [];
    if (!cities.haveList) return menuItems;
    cities.forEach((item) => menuItems.add(_menuItem(item)));
    return menuItems;
  }

  DropdownMenuItem<District> _menuItem(District item) {
    var empty_space = '    ';
    var overflow = TextOverflow.ellipsis;
    var style = sl<TextStyles>().text14_400(black);
    var label = Text('$empty_space${item.label}', maxLines: 1, overflow: overflow, style: style);
    return DropdownMenuItem<District>(value: item, child: label);
  }

  String get _getHint {
    if (type == 'division') {
      return 'Select any division'.translate;
    } else if (type == 'district') {
      return 'Select any district'.translate;
    } else {
      return 'Select any sub-district'.translate;
    }
  }
}
