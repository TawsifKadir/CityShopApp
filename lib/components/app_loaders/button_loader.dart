import 'package:flutter/material.dart';

import 'package:grs/constants/colors.dart';

class ButtonLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var progressbar = CircularProgressIndicator(color: primary, strokeWidth: 2, backgroundColor: white.withOpacity(0.3));
    return Container(width: double.infinity, alignment: Alignment.center, child: SizedBox(width: 24, height: 24, child: progressbar));
  }
}
