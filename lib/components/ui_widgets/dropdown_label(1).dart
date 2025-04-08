import 'package:flutter/material.dart';

import 'package:grs/constants/colors.dart';
import 'package:grs/di.dart';
import 'package:grs/utils/text_styles.dart';

class DropdownLabel extends StatelessWidget {
  final String label;
  const DropdownLabel(this.label);

  @override
  Widget build(BuildContext context) {
    var empty_space = '    ';
    var style = sl<TextStyles>().text14_400(black);
    return Text('$empty_space$label', maxLines: 1, overflow: TextOverflow.ellipsis, style: style);
  }
}
