import 'package:flutter/material.dart';

import 'package:grs/constants/colors.dart';
import 'package:grs/di.dart';
import 'package:grs/library_widgets/svg_image.dart';
import 'package:grs/models/dummy/complain_menu.dart';
import 'package:grs/utils/text_styles.dart';

class ComplainMenuList extends StatelessWidget {
  final int menuIndex;
  final Function(int) onTap;
  final ScrollController scrollController;
  const ComplainMenuList({required this.menuIndex, required this.onTap, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        controller: scrollController,
        clipBehavior: Clip.antiAlias,
        itemBuilder: _complainMenuCard,
        scrollDirection: Axis.horizontal,
        itemCount: complainMenuList.length,
        physics: const BouncingScrollPhysics(),
      ),
    );
  }

  Widget _complainMenuCard(BuildContext context, int index) {
    var menu = complainMenuList[index];
    var selected = index == menuIndex;
    var radius = BorderRadius.circular(06);
    var marginLeft = index == 0 ? 24.0 : 0.0;
    var marginRight = index == complainMenuList.length - 1 ? 24.0 : 12.0;
    var border = Border.all(color: selected ? primary : grey40);
    return InkWell(
      onTap: () => onTap(index),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: 14, right: 16),
        margin: EdgeInsets.only(left: marginLeft, right: marginRight),
        decoration: BoxDecoration(borderRadius: radius, color: selected ? primary : cardShade, border: border),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgImage(image: menu.icon, height: 20, width: 20, color: selected ? white : grey80),
            const SizedBox(width: 04),
            Text(menu.label, textAlign: TextAlign.center, style: sl<TextStyles>().text14_500(selected ? white : grey80)),
          ],
        ),
      ),
    );
  }
}
