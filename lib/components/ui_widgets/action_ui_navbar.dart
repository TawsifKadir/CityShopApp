import 'package:flutter/material.dart';

import 'package:grs/components/ui_widgets/nav_button_box.dart';
import 'package:grs/extensions/string_ext.dart';

class ActionUiNavbar extends StatelessWidget {
  final bool loader;
  final String elevatedLabel;
  final String outlineLabel;
  final Function() elevatedOnTap;
  final Function() outlineOnTap;

  const ActionUiNavbar({
    required this.loader,
    required this.elevatedLabel,
    required this.elevatedOnTap,
    required this.outlineLabel,
    required this.outlineOnTap,
  });

  @override
  Widget build(BuildContext context) {
    var outlinedButton = OutlinedButton(child: Text(outlineLabel.translate), onPressed: outlineOnTap);
    var elevatedButton = ElevatedButton(onPressed: loader ? null : elevatedOnTap, child: Text(elevatedLabel.translate));
    return NavButtonBox(
      loader: loader,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Expanded(child: outlinedButton), const SizedBox(width: 20), Expanded(child: elevatedButton)],
      ),
    );
  }
}
