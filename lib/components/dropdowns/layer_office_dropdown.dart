import 'package:flutter/material.dart';

import 'package:grs/components/ui_widgets/dropdown_label.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/list_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/models/doptor_apis/office_by_layer.dart';
import 'package:grs/utils/size_config.dart';
import 'package:grs/utils/text_styles.dart';

class LayerOfficeDropdown extends StatelessWidget {
  final OfficeByLayer? layerOffice;
  final List<OfficeByLayer> layerOfficeList;
  final Function(OfficeByLayer?)? onChanged;

  const LayerOfficeDropdown({required this.layerOffice, required this.layerOfficeList, required this.onChanged});

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
          // value: null,
          value: layerOffice,
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
    if (layerOffice == null || !layerOfficeList.haveList) return 'Select office'.translate;
    var index = layerOfficeList.indexWhere((item) => item.id == layerOffice!.id);
    return index < 0 ? 'Select office'.translate : layerOfficeList[index].office_name;
  }

  List<DropdownMenuItem<OfficeByLayer>> get _dropdownMenuItems {
    List<DropdownMenuItem<OfficeByLayer>> menuItems = [];
    if (!layerOfficeList.haveList) return menuItems;
    layerOfficeList.forEach((item) => menuItems.add(_menuItem(item)));
    return menuItems;
  }

  DropdownMenuItem<OfficeByLayer> _menuItem(OfficeByLayer item) {
    var empty_space = '    ';
    var overflow = TextOverflow.ellipsis;
    var style = sl<TextStyles>().text14_400(black);
    var label = Text('$empty_space${item.office_name}', maxLines: 1, overflow: overflow, style: style);
    return DropdownMenuItem<OfficeByLayer>(value: item, child: label);
  }
}
