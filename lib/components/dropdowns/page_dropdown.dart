import 'package:flutter/material.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/utils/size_config.dart';
import 'package:grs/utils/text_styles.dart';

import '../../di.dart';

class PageDropdown extends StatelessWidget {
  final int pageCount;
  final int? selectedPage;
  final Function(int?)? onChanged;

  const PageDropdown({
    required this.pageCount,
    required this.selectedPage,
    required this.onChanged,
  });

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
        child: DropdownButton<int>(
          isDense: true,
          value: selectedPage,
          isExpanded: true,
          onChanged: onChanged,
          items: _dropdownMenuItems,
          icon: Padding(padding: const EdgeInsets.only(right: 4), child: dropdownIcon),
        ),
      ),
    );
  }

  // Generate dropdown menu items based on page count
  List<DropdownMenuItem<int>> get _dropdownMenuItems {
    return List<DropdownMenuItem<int>>.generate(
      pageCount,
          (index) => _menuItem(index + 1),
    );
  }

  DropdownMenuItem<int> _menuItem(int page) {
    return DropdownMenuItem<int>(
      value: page,
      child: Text(
        '   $page', // Add spacing for alignment
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: sl<TextStyles>().text14_400(black),
      ),
    );
  }
}
