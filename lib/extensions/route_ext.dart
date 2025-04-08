import 'package:flutter/material.dart';

import 'package:grs/utils/keys.dart';

extension PushRoute on Widget {
  Future<dynamic> push() {
    var context = navigatorKey.currentState!.context;
    return Navigator.push(context, MaterialPageRoute(builder: (context) => this));
  }

  Future<dynamic> pushAndRemoveUntil() {
    var context = navigatorKey.currentState!.context;
    return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => this), (route) => false);
  }
}

extension PopRoute on void {
  void backToPrevious() => Navigator.of(navigatorKey.currentState!.context).pop();
}
