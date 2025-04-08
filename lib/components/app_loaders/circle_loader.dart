import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:grs/constants/colors.dart';

class CircleLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var iosLoader = const CupertinoActivityIndicator(color: primary, radius: 20);
    var androidLoader = CircularProgressIndicator(color: primary, backgroundColor: primary.withOpacity(0.3));
    return Platform.isIOS ? iosLoader : SizedBox(height: 36, width: 36, child: androidLoader);
  }
}
