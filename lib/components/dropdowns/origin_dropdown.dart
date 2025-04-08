import 'package:flutter/material.dart';

import 'package:grs/components/ui_widgets/dropdown_label.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/list_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/models/doptor_apis/origin.dart';
import 'package:grs/utils/size_config.dart';
import 'package:grs/utils/text_styles.dart';

class OriginDropdown extends StatelessWidget {
  final Origin? origin;
  final List<Origin> originList;
  final Function(Origin?)? onChanged;

  const OriginDropdown({required this.origin, required this.originList, required this.onChanged});

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
          value: origin,
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
    if (origin == null || !originList.haveList) return 'Select origin'.translate;
    var index = originList.indexWhere((item) => item.id == origin!.id);
    return index < 0 ? 'Select origin'.translate : originList[index].office_name;
  }

  List<DropdownMenuItem<Origin>> get _dropdownMenuItems {
    List<DropdownMenuItem<Origin>> menuItems = [];
    if (!originList.haveList) return menuItems;
    originList.forEach((item) => menuItems.add(_menuItem(item)));
    return menuItems;
  }

  DropdownMenuItem<Origin> _menuItem(Origin item) {
    var empty_space = '    ';
    var overflow = TextOverflow.ellipsis;
    var style = sl<TextStyles>().text14_400(black);
    var label = Text('$empty_space${item.office_name}', maxLines: 1, overflow: overflow, style: style);
    return DropdownMenuItem<Origin>(value: item, child: label);
  }
}
